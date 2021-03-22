defmodule Jw315ParserTest do
  use ExUnit.Case

  doctest CommServer

  import SweetXml

  alias CommServer.Message
  alias CommServer.Parsers.Jw315Parser

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Get Requested Products" do
    jw315 = %Message{xml: readXml(), type: "JW315"}
    products = Jw315Parser.to_map(jw315)
    IO.inspect(products)
  end

  defp readXml() do
    IO.inspect(@fixtures_path |> Path.join("jw315"))
    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
