defmodule CommServer.MessageHandler do
  alias CommServer.Message

  def process(%Message{} = message) do
    Task.async(fn ->
      message
      |> create_follow_up_messages()
    end)
  end

  def create_follow_up_messages(%Message{type: "JW315"} = message) do
    # Task.start(fn -> message |> Jw316Creator.create() |> Persister.save() end)
    # Task.start(fn -> message |> Jw301Creator.create() |> Persister.save() end)
  end
end
