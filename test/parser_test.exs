defmodule ParserTest do
  use ExUnit.Case

  doctest CommServer

  alias CommServer.Message
  alias CommServer.Parser

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Get Sender from Jw315" do
    assert "22227338" =
             Parser.get_value(%Message{type: "JW315", xml: read_xml()}, "jw315:Afzender")
  end

  test "Get Bsn from Jw315" do
    assert "999900006" == Parser.get_value(%Message{type: "JW315", xml: read_xml()}, "jw315:Bsn")
  end

  test "Get Referentie Aanbieder" do
    assert "88efe721359587" = Parser.get_value_in_product(get_product(read_xml()), :referentie_aanbieder)
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
