defmodule CommServer.Parser do
  import SweetXml
  alias CommServer.Message

  def parse(soap_envelope) do
    data = soap_envelope
      |> xpath(~x"//SOAP-ENV:Envelope",
        type: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichttype/text()",
        subtype: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtsubtype/text()",
        version_major: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtversie/text()",
        version_minor: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtsubversie/text()",
        institution: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Afzender/ns3:Code/text()",
        municipality:
          ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Geadresseerden/ns3:Relatie/ns3:Code/text()",
        trace_id: ~x"./SOAP-ENV:Header/ns2:ConversatieHeader/ns4:TraceerId/text()",
        conversation_id: ~x"./SOAP-ENV:Header/ns2:ConversatieHeader/ns4:ConversatieId/text()",
        xml_zipped_encoded:
          ~x"./SOAP-ENV:Body/ns2:IndienenBericht/ns2:Request/ns1:Bericht/ns1:Data/text()"
      )

    IO.inspect(data)

    %Message{
      type: data.type,
      subtype: data.subtype,
      trace_id: data.trace_id,
      conversation_id: data.conversation_id,
      version_major: data.version_major,
      version_minor: data.version_minor,
      institution: data.institution,
      municipality: data.municipality,
      xml: data.xml_zipped_encoded |> to_string() |> decode() |> unzip(),
      status: %CommServer.Status{}
    }
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
      _ -> raise "Unzipping failed!"
    end
  end
end
