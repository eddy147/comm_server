defmodule CommServer.Handler do
  alias CommServer.Parser

  def loadMessage(soap_envelope) do
    message = Parser.parse(soap_envelope)
    message_loaded = update_status_to_loaded(message)

    IO.inspect(message_loaded)
    #todo
      # build the response
      # save the message
      # send jw301 for /pull

    ~s{<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
    <s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
       <IndienenBerichtResponse xmlns="http://schemas.vecozo.nl/berichtuitwisseling/v3">
          <IndienenBerichtResult>
             <ConversatieId xmlns="http://schemas.vecozo.nl/berichtuitwisseling/messages/v3">fc6d5c90-5630-4270-aba2-bc1be7936502</ConversatieId>
             <TraceerId xmlns="http://schemas.vecozo.nl/berichtuitwisseling/messages/v3">fc6d5c90-5630-4270-aba2-bc1be7936502</TraceerId>
          </IndienenBerichtResult>
       </IndienenBerichtResponse>
    </s:Body>
 </s:Envelope>}

  end

  defp update_status_to_loaded(message) do
    loaded_status = Map.put(message.status, :loaded, true)
    Map.put(message, :status, loaded_status)
  end
end
