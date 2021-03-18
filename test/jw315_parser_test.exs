defmodule Jw315ParserTest do
  use ExUnit.Case

  doctest CommServer

  import SweetXml

  alias CommServer.Messages.Message
  alias CommServer.Parsers.Jw315Parser

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Get Client Details" do
    jw315 = %Message{xml: readXml(), subtype: "JW315"}
    assert "999900006" == Jw315Parser.parse(jw315, :bsn)
  end

  test "Get Requested Products" do
    jw315 = %Message{xml: readXml(), subtype: "JW315"}
    products = Jw315Parser.parse(jw315, :products)
    IO.inspect(products)
  end

  defp readXml() do
    IO.inspect(@fixtures_path |> Path.join("jw315"))
    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
