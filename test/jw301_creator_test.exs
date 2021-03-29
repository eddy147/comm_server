defmodule Jw301CreatorTest do
  use ExUnit.Case

  doctest CommServer

  alias CommServer.Message
  alias CommServer.Jw301Creator

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Create Xml" do
    jw301 = Jw301Creator.create(%Message{xml: readXml(), type: "JW315"})
    IO.inspect(jw301.xml)
  end

  defp readXml() do
    IO.inspect(@fixtures_path |> Path.join("jw315"))

    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
