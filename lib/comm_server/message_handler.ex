defmodule CommServer.MessageHandler do
  alias CommServer.Jw301Creator
  alias CommServer.Jw316Creator
  alias CommServer.Message
  alias CommServer.Persister

  def process(%Message{} = message) do
    Task.async(fn ->
      message
      |> MessagePersister.upsert_message()
      |> create_follow_up_messages()
    end)
  end

  def create_follow_up_messages(%Message{type: "JW315"} = message) do
    # Task.start(fn -> message |> Jw316Creator.create() |> Persister.save() end)
    # Task.start(fn -> message |> Jw301Creator.create() |> Persister.save() end)
  end
end
