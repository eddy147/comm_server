defmodule CommServer.XmlToMap do
  alias Quinn

  def to_map(xml) do
    xml |> Quinn.parse(%{strip_namespaces: true})
  end
end
