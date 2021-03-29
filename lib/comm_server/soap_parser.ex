defmodule CommServer.SoapParser do
  import SweetXml
  alias CommServer.Message

  def parse(soap_envelope) do
    soap_envelope_stripped = soap_envelope |> strip_namespace()

    xml =
      soap_envelope_stripped
      |> xpath(~x[//Data/text()]s)
      |> decode()
      |> unzip()

    message = %Message{
      uuid: soap_envelope_stripped |> xpath(~x[//TraceerId/text()]s),
      conversation_uuid: soap_envelope_stripped |> xpath(~x[//ConversatieId/text()]s),
      action: soap_envelope_stripped |> xpath(~x[//Actie/text()]s),
      type: soap_envelope_stripped |> xpath(~x[//Berichtsubtype/text()]s),
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
        xml_file |> File.read!()

      _ ->
        raise "Unzipping failed!"
    end
  end
end
