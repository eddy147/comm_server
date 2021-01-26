defmodule CommServer.ResponseCreator do
  alias CommServer.Message

  def create_response(%Message{action: "VerzoekToewijzing"} = message) do
    IO.puts("A")
  end

  def create_response(%Message{} = message) do
    IO.puts("B")
  end
end
