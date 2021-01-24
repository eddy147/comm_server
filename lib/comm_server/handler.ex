defmodule CommServer.Handler do
  import SweetXml

  def loadMessage(soap_envelope) do
    IO.puts(__MODULE__)

    message =
      soap_envelope
      |> xpath(~x"//SOAP-ENV:Envelope",
        type: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichttype/text()",
        subtype: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtsubtype/text()",
        version_major: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtversie/text()",
        version_minor: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtsubversie/text()",
        raw: ~x"./SOAP-ENV:Body/ns2:IndienenBericht/ns2:Request/ns1:Bericht/ns1:Data/text()"
      )

    IO.inspect(message)

    {:ok, zipped} = message.raw |> to_string() |> Base.decode64()
    {:ok, file} = zipped |> :zip.unzip()

    "OK"
  end
end
