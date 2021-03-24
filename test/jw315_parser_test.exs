defmodule Jw315ParserTest do
  use ExUnit.Case

  doctest CommServer

  import SweetXml

  alias CommServer.Message
  alias CommServer.ParseJw315
  alias CommServer.NodeFinder

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Get Requested Products" do
    jw315 = %Message{xml: readXml(), type: "JW315"}
    [msg] = ParseJw315.to_map(jw315)
    IO.inspect(NodeFinder.find(msg, :aangevraagd_product))
  end

  defp readXml() do
    IO.inspect(@fixtures_path |> Path.join("jw315"))
    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
