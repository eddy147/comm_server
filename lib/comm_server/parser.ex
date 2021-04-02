defmodule CommServer.Parser do
  alias CommServer.Message

  def get_value(%Message{type: "JW315", xml: xml}, key) do
    xml
    |> Quinn.XmlParser.parse()
    |> Quinn.find(String.to_atom(key))
    |> List.first()
    |> Map.fetch!(:value)
    |> List.first()
  end

  # def get_value_from_node(node, key) do
  #   IO.inspect(
  #     node
  #     |> Quinn.find(String.to_atom(key))
  #   )
  #   |> get_value_from_list()
  # end

  def get_list(%Message{type: "JW315", xml: xml}, key) do
    xml
    |> Quinn.XmlParser.parse(%{strip_namespaces: true})
    |> Quinn.find(String.to_atom(key))
     |> List.first()
  end

  def flatten_products(%Message{type: "JW315"} = jw315) do
    jw315.xml
    |> Quinn.XmlParser.parse(%{strip_namespaces: true})
    |> Quinn.find(:aangevraagd_product)
    |> Enum.each(fn p -> flatten_product(p, %{}) end)
  end

  def flatten_product(%{} = p, %{} = _result) do
    IO.inspect(p)
  end

  def flatten_value(%{attr: attr, name: name, value: value}) do
    
  end

end
