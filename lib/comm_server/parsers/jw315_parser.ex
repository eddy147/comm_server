defmodule CommServer.Parsers.Jw315Parser do
  import Meeseeks.XPath
  alias CommServer.Messages.Message

  def parse(%Message{subtype: "JW315"} = jw315, :bsn) do
    jw315.xml
      |> Meeseeks.parse(:xml)
      |> Meeseeks.one(xpath("//jw315:Bsn"))
      |> Meeseeks.text()
  end

  def parse(%Message{subtype: "JW315"} = jw315, :products) do
    jw315.xml
      |> Meeseeks.parse(:xml)
      |> Meeseeks.all(xpath("//jw315:AangevraagdProduct"))
      |> Meeseeks.tree()
  end

end
