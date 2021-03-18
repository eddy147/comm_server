defmodule CommServer.Parsers.Jw315Parser do
  import SweetXml
  alias CommServer.Messages.Message

  def parse(%Message{subtype: "JW315"} = jw315, :bsn) do
    jw315.xml |> xpath(~x[/jw315:Bericht/jw315:Client/jw315:Bsn/text()]s)
  end
end
