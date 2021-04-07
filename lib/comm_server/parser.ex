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

  def get_value_in_product(p, search), do: get_value_in_product(p.value, search, "")

  defp get_value_in_product([], _search, result), do: result

  defp get_value_in_product([head | tail], search, result) do
    if is_map(List.first(head.value)) do
      get_value_in_product(head.value, search, result)
    else
      if head.name == search do
        get_value_in_product([], search, result <> List.first(head.value))
      else
        get_value_in_product(tail, search, result)
      end
    end
  end
end
