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

  def get_products(%Message{type: "JW315", xml: xml}) do
    xml
    |> Quinn.XmlParser.parse(%{strip_namespaces: true})
    |> Quinn.find(:aangevraagd_product)
  end

  # def get_value(_p, _search), do: "88efe721359587"

  def get_value_in_product(p, search), do: get_value_in_product(p.value, search, "")

  def get_value_in_product(p, _search, result) when [] == p, do: result
  def get_value_in_product(p, _search, _result) when is_binary(p), do: p
  def get_value_in_product(p, search, result) when is_map(p), do: get_value_in_product(p.value, search, result)
  def get_value_in_product([head | tail], search, result) do
    if is_map(head.value) do
      get_value_in_product([head.value], search, result)
    else
      if head.name == search do
        get_value_in_product([], search, result <> List.first(head.value))
      else
        get_value_in_product(tail, search, result)
      end
    end
  end
end
