defmodule ParserTest do
  use ExUnit.Case

  doctest CommServer

  alias CommServer.Message
  alias CommServer.Parser

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Get Sender from Jw315" do
    assert "22227338" ==
             Parser.find(%Message{type: "JW315", xml: read_xml()}, :afzender)
  end

  test "Get Bsn from Jw315" do
    assert "999900006" == Parser.find(%Message{type: "JW315", xml: read_xml()}, :bsn)
  end

  test "Get Referentie Aanbieder" do
    assert "88efe721359587" ==
             Parser.find(get_product(read_xml()), :referentie_aanbieder)
  end

  test "Get Category" do
    assert "45" == Parser.find(get_product(read_xml()), :categorie)
  end

  test "Get Product Code" do
    assert "YS1U" == Parser.find(get_product(read_xml()), :code)
  end

  test "Get Volume" do
    assert "87" == Parser.find(get_product(read_xml()), :volume)
  end

  test "Flat map Products" do
    flat_mapped_products =
      %Message{type: "JW315", xml: read_xml()}
      |> Parser.products_flat_map()

    assert flat_mapped_products = [
             %{
               categorie: "45",
               code: "YS1U",
               omvang: %{eenheid: "83", frequentie: "4", volume: "87"},
               raamcontract: "2",
               referentie_aanbieder: "88efe721359587",
               toewijzing_ingangsdatum: "2021-01-01",
               verwijzer: %{naam: "Utrecht", type: "01"}
             }
           ]
  end

  defp get_product(xml) do
    %Message{type: "JW315", xml: xml}
    |> Parser.get_products()
    |> List.first()
  end

  defp read_xml() do
    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
