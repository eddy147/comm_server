defmodule CommServer.Handler do
  import SweetXml

  def loadMessage(soap_envelope) do

    IO.puts(__MODULE__)

    #standard = soap_envelope |> xpath(~x"//ns4:Berichtsubtype/text()")
    #map = soap_envelope |> xmap(s: ~x"//soapenv:Envelope")
    message = soap_envelope
    |> xpath(~x"//SOAP-ENV:Envelope",
      type: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichttype/text()",
      subtype: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtsubtype/text()",
      version_major: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtversie/text()",
      version_minor: ~x"./SOAP-ENV:Header/ns2:RouteringHeader/ns4:Berichtsubversie/text()",
      raw: ~x"./SOAP-ENV:Body/ns2:IndienenBericht/ns2:Request/ns1:Bericht/ns1:Data/text()")

    message.raw
  end

end
