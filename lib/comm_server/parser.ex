defmodule CommServer.Parser do
  import SweetXml
  alias CommServer.Structs.Message

  def parse(soap_envelope) do
    soap_envelope_stripped = soap_envelope |> strip_namespace()

    xml =
      soap_envelope_stripped
      |> xpath(~x[//Data/text()]s)
      |> decode()
      |> unzip()

    xml_stripped = strip_namespace(xml)

    message = %Message{
      type: soap_envelope_stripped |> xpath(~x[//Berichttype/text()]s),
      subtype: soap_envelope_stripped |> xpath(~x[//Berichtsubtype/text()]s),
      trace_id: soap_envelope_stripped |> xpath(~x[//TraceerId/text()]s),
      conversation_id: soap_envelope_stripped |> xpath(~x[//ConversatieId/text()]s),
      version_major: soap_envelope_stripped |> xpath(~x[//Berichtversie/text()]s),
      version_minor: soap_envelope_stripped |> xpath(~x[//Berichtsubversie/text()]s),
      action: soap_envelope_stripped |> xpath(~x[//Actie/text()]s),
      institution: soap_envelope_stripped |> xpath(~x[//Afzender/Relatie/Code/text()]s),
      municipality: soap_envelope_stripped |> xpath(~x[//Geadresseerden/Relatie/Code/text()]s),
      xml: xml_stripped,
      xml_origin: xml,
      status: %CommServer.Status{}
    }

    message
  end

  def strip_namespace(xml) do
    xml2 = Regex.replace(~r/<([a-zA-Z0-9]+):/, xml, "<")
    xml3 = Regex.replace(~r/<\/([a-zA-Z0-9]+):/, xml2, "</")
    xml4 = strip_whitespace(xml3)
    xml4
  end

  def strip_whitespace(xml) do
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
