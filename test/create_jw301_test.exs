defmodule CreateJw301Test do
  use ExUnit.Case

  doctest CommServer

  alias CommServer.Message
  alias CommServer.Jw301Creator

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Get Requested Products" do
    jw301 = Jw301Creator.create(%Message{xml: readXml(), type: "JW315"})
  end

  defp readXml() do
    IO.inspect(@fixtures_path |> Path.join("jw315"))

    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
