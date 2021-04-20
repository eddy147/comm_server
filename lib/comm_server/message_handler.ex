defmodule CommServer.MessageHandler do
  alias CommServer.Message
  alias CommServer.Jw301Creator
  alias CommServer.Persister

  def process(%Message{} = message) do
    Task.async(fn ->
      message
      |> create_follow_up_messages()
    end)
  end

  def create_follow_up_messages(%Message{type: "JW315"} = message) do
    message |> Jw301Creator.create() |> Persister.save()
  end
end
