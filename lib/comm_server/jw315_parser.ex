defmodule CommServer.Parsers.Jw315Parser do
  alias Quinn
  alias CommServer.Message

  def to_map(%Message{type: "JW315"} = jw315) do
    jw315.xml
    |> Quinn.parse(%{strip_namespaces: true})
  end
end
