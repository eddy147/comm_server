defmodule CommServer.MessageHandler do
  alias CommServer.Jw301Creator
  alias CommServer.Jw316Creator
  alias CommServer.Messages.Message

  def process(%Message{} = message) do
      Task.async(fn ->
        message
        |> MessageCreator.upsert_message()
        |> update_status(:received)
        |> create()
      end)
  end

  def create(%Message{subtype: "JW315"} = message) do
    Task.start(fn -> Jw316Creator.create(message, :jw316) end)
    Task.start(fn -> Jw301Creator.create(message, :jw301) end)
    message
  end

  defp update_status(message, status) do
    Map.replace(message, :status, Atom.to_string(status))
  end
end
