defmodule CommServer.MessageHandler do
  alias CommServer.Jw301Creator
  alias CommServer.Jw316Creator
  alias CommServer.Messages.Message
  alias CommServer.Persister

  def process(%Message{} = message) do
    Task.async(fn ->
      message
      |> MessagePersister.upsert_message()
      |> update_status(:received)
      |> create_follow_up_messages()
    end)
  end

  def create_follow_up_messages(%Message{subtype: "JW315"} = message) do
    Task.start(fn -> message |> Jw316Creator.create() |> Persister.upsert_message() end)
    Task.start(fn -> message |> Jw301Creator.create() |> Persister.upsert_message() end)
  end

  defp update_status(message, status) do
    Map.replace(message, :status, Atom.to_string(status))
  end
end
