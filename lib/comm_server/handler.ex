defmodule CommServer.Handler do
  import SweetXml
  alias CommServer.Parser

  def loadMessage(soap_envelope) do
    message = Parser.parse(soap_envelope)
    IO.inspect(message)
    "OK"
  end
end
