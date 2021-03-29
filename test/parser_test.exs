defmodule ParserTest do
  use ExUnit.Case

  doctest CommServer

  alias CommServer.Message
  alias CommServer.Parser

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Get Client Bsn from Jw315" do
    bsn = Parser.get_client_bsn(%Message{type: "JW315", xml: read_xml()})
    |> List.first()
    IO.inspect(bsn)
    [bsn_value] = bsn.value
    assert "999900006" == bsn_value
  end

  defp read_xml() do
    IO.inspect(@fixtures_path |> Path.join("jw315"))

    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
