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

  # def find_value(_p, _search), do: "88efe721359587"

  def find_value(p, search), do: _find_value(p.value, search, "")

  def _find_value(p, _search, result) when [] == p, do: result
  def _find_value(p, _search, _result) when is_binary(p), do: p
  def _find_value(p, search, result) when is_map(p), do: _find_value(p.value, search, result)
  def _find_value([head | tail], search, result) do
    IO.inspect(head)
    if is_map(head.value) do
      _find_value([head.value], search, result)
    else
      if head.name == search do
        _find_value([], search, result <> List.first(head.value))
      else
        _find_value(tail, search, result)
      end
    end
  end
  def _find_value(p, _search, _result) do
    IO.puts("What AM I?")
    IO.inspect(p)
  end

  # def _find_value([head | tail], search, result) do
  #   if (is_map(head.value)) do
  #     _find_value([head.value], search, result)
  #   else
  #     if (head.name == search) do
  #       _find_value([], search, result <> head.value)
  #     else
  #       _find_value(tail, search, result)
  #     end
  #   end
  # end
end
