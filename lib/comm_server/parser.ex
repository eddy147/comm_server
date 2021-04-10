defmodule CommServer.Parser do
  alias CommServer.Message

  def get_value(%Message{xml: xml}, key) do
    xml
    |> Quinn.XmlParser.parse(%{strip_namespaces: true})
    |> get_value_from_parsed_data(key)
  end

  def get_value_from_parsed_data(data, key) do
    data |> Quinn.find(key) |> get_value_from_node()
  end

  def get_value_from_node([]), do: ""

  def get_value_from_node([head | _tail]) do
    head
    |> Map.fetch!(:value)
    |> List.first()
  end

  def get_products(%Message{type: "JW315", xml: xml}) do
    xml
    |> Quinn.XmlParser.parse(%{strip_namespaces: true})
    |> Quinn.find(:aangevraagd_product)
  end

  def products_flat_map(%Message{type: "JW315"} = msg) do
    products_flat_map(get_products(msg), [])
  end

  defp products_flat_map([], result), do: result

  defp products_flat_map([head | tail], result) do
    products_flat_map(
      tail,
      result ++
        [
          %{
            referentie_aanbieder: get_value_from_parsed_data(head, :referentie_aanbieder),
            categorie: get_value_from_parsed_data(head, :categorie),
            code: get_value_from_parsed_data(head, :code),
            toewijzing_ingangsdatum: get_value_from_parsed_data(head, :toewijzing_ingangsdatum),
            omvang: %{
              volume: get_value_from_parsed_data(head, :volume),
              eenheid: get_value_from_parsed_data(head, :eenheid),
              frequentie: get_value_from_parsed_data(head, :frequentie)
            },
            verwijzer: %{
              type: get_value_from_parsed_data(head, :aantal),
              naam: get_value_from_parsed_data(head, :naam)
            },
            raamcontract: get_value_from_parsed_data(head, :raamcontract)
          }
        ]
    )
  end
end
