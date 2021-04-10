defmodule Jw301CreatorTest do
  use ExUnit.Case

  doctest CommServer

  alias CommServer.Message
  alias CommServer.Parser
  alias CommServer.Jw301Creator

  @fixtures_path Path.expand("./fixtures", __DIR__)

  test "Create Xml" do
    jw301 = Jw301Creator.create(%Message{xml: readXml(), type: "JW315"})

    assert %Message{uuid: uuid, type: "JW301", xml: xml} = jw301
    assert is_binary(jw301.xml)
    assert "0344" == Parser.find(jw301, :afzender)
    assert "22227338" == Parser.find(jw301, :ontvanger)
    assert Date.utc_today() |> Date.to_string() == Parser.find(jw301, :dagtekening)
    assert "999900006" == Parser.find(jw301, :bsn)
    assert "Vries" = Parser.find(jw301, :achternaam)
  end

  defp readXml() do
    @fixtures_path
    |> Path.join("jw315.xml")
    |> File.read!()
  end
end
