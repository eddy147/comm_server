defmodule CommServer.Parser do
  alias CommServer.Message

  def find(%Message{xml: xml}, keys) do
    xml
    |> Quinn.XmlParser.parse(%{strip_namespaces: true})
    |> find(keys)
  end

  def find(data, keys) do
    data |> Quinn.find(keys) |> find()
  end

  def find([]), do: ""

  def find([head | _tail]) do
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

  defp randomiser(), do: Application.get_env(:comm_server, :randomiser)

  defp products_flat_map([head | tail], result) do
    products_flat_map(
      tail,
      result ++
        [
          %{
            toewijzing_nummer: randomiser().rand(7,:numeric),
            referentie_aanbieder: find(head, :referentie_aanbieder),
            categorie: find(head, :categorie),
            code: find(head, :code),
            toewijzing_ingangsdatum: find(head, :toewijzing_ingangsdatum),
            omvang: %{
              volume: find(head, :volume),
              eenheid: find(head, :eenheid),
              frequentie: find(head, :frequentie)
            },
            verwijzer: %{
              type: find(head, :type),
              naam: find(head, :naam)
            },
            raamcontract: find(head, :raamcontract)
          }
        ]
    )
  end
end
