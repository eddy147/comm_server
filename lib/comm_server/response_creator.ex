defmodule CommServer.ResponseCreator do
  alias CommServer.Message

  def create(%Message{action: "VerzoekToewijzing"} = message) do
    "<Bla />"
  end
end
