defmodule ParserTest do
  use ExUnit.Case

  doctest CommServer

  alias CommServer.Message
  alias CommServer.Parser

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Get Sender from Jw315" do
    bsn = Parser.get_client_bsn(%Message{type: "JW315", xml: read_xml()})
    assert "999900006" == bsn
  end

  defp read_xml() do
    IO.inspect(@fixtures_path |> Path.join("jw315"))

    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
