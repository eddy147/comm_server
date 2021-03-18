defmodule CommServer.SoapParser do
  import SweetXml
  alias CommServer.Messages.Message

  @spec parse(binary) :: %CommServer.Messages.Message{
          __meta__: Ecto.Schema.Metadata.t(),
          action: any,
          conversation_id: any,
          id: any,
          inserted_at: nil,
          institution: any,
          municipality: any,
          status: nil,
          subtype: any,
          type: any,
          updated_at: nil,
          version_major: integer,
          version_minor: integer,
          xml: binary
        }
  def parse(soap_envelope) do
    soap_envelope_stripped = soap_envelope |> strip_namespace()

    xml =
      soap_envelope_stripped
      |> xpath(~x[//Data/text()]s)
      |> decode()
      |> unzip()

    message = %Message{
      id: soap_envelope_stripped |> xpath(~x[//TraceerId/text()]s),
      conversation_id: soap_envelope_stripped |> xpath(~x[//ConversatieId/text()]s),
      action: soap_envelope_stripped |> xpath(~x[//Actie/text()]s),
      type: soap_envelope_stripped |> xpath(~x[//Berichttype/text()]s),
      subtype: soap_envelope_stripped |> xpath(~x[//Berichtsubtype/text()]s),
      version_major:
        soap_envelope_stripped |> xpath(~x[//Berichtversie/text()]s) |> String.to_integer(),
      version_minor:
        soap_envelope_stripped |> xpath(~x[//Berichtsubversie/text()]s) |> String.to_integer(),
      institution: soap_envelope_stripped |> xpath(~x[//Afzender/Code/text()]s),
      municipality: soap_envelope_stripped |> xpath(~x[//Relatie/Code/text()]s),
      xml: xml
    }

    message
  end

  def getClientInfoByTag(%Message{} = message, tag) do
    message.xml |> xpath(~x[//Client/#{tag}/text()]s)
  end

  def fetchProducts(%Message{subtype: "JW315"} = message) do
    message.xml |> xpath(~x[//AangevraagdProduct])
  end

  defp strip_namespace(xml) do
    xml2 = Regex.replace(~r/<([a-zA-Z0-9]+):/, xml, "<")
    xml3 = Regex.replace(~r/<\/([a-zA-Z0-9]+):/, xml2, "</")
    xml4 = strip_whitespace(xml3)
    xml4
  end

  defp strip_whitespace(xml) do
    Regex.replace(~r/(\s+>)+/, xml, "")
  end

  defp decode(encoded_string) do
    case Base.decode64(encoded_string) do
      {:ok, decoded} -> decoded
      _ -> raise "Decoding failed!"
    end
  end

  defp unzip(zipped_xml) do
    case :zip.unzip(zipped_xml) do
      {:ok, xml_file} ->
        xml_file |> CommServer.File.read()

      _ ->
        raise "Unzipping failed!"
    end
  end
end
