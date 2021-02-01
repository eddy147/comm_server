defmodule CommServer.Handler do
  alias CommServer.Parser
  alias CommServer.ResponseCreator

  def loadMessage(soap_envelope) do
    message = Parser.parse(soap_envelope)
    message_loaded = update_status_to_loaded(message)
    ResponseCreator.create_response(message_loaded)
  end

  defp update_status_to_loaded(message) do
    loaded_status = Map.put(message.status, :loaded, true)
    Map.put(message, :status, loaded_status)
  end
end
