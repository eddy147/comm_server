defmodule CommServer.Parser do
  alias CommServer.Message

  def get_client_bsn(%Message{type: "JW315", xml: xml}) do
    xml |> Quinn.XmlParser.parse() |> Quinn.find(String.to_atom("jw315:Bsn"))
  end
end
