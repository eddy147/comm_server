defmodule CommServer.Parser do
  alias CommServer.Message

  def get_sender_agb(%Message{type: "JW315", xml: xml}) do
    l = xml |> Quinn.XmlParser.parse()
    List.flatten(l)
    xml |> Quinn.XmlParser.parse() |> Quinn.find(String.to_atom("jw315:Afzender"))
  end

  def get_client_bsn(%Message{type: "JW315", xml: xml}) do
    xml
    |> Quinn.XmlParser.parse()
    |> Quinn.find(String.to_atom("jw315:Bsn"))
    |> List.first()
    |> Map.fetch!(:value)
    |> List.first()
  end
end
