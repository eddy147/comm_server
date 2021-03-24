defmodule CommServer.ParseJw315 do
  alias CommServer.XmlToMap
  alias CommServer.Message

  def to_map(%Message{type: "JW315"} = jw315) do
    jw315.xml
    |> XmlToMap.to_map()
  end

  def get_bsn(xml_map) do
    IO.inspect(xml_map)
  end
end
