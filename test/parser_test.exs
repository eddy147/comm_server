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

  test "Get Details from product 1" do
    Parser.flatten_products(%Message{type: "JW315", xml: read_xml()})
  end

  defp read_xml() do
    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
