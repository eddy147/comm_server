defmodule CommServer.MessageHandler do
  alias CommServer.Parser
  alias CommServer.MessagePersister
  alias CommServer.Messages.Message

  @spec process(binary) :: {:ok, map}
  def process(soap_envelope) do
    task =
      Task.async(fn ->
        soap_envelope
        |> Parser.parse()
        |> MessagePersister.upsert_message()
        |> update_status(:received)
        |> create()
      end)

    message = Task.await(task)

    {:ok, message}
  end

  def create(%Message{subtype: "JW315"} = message) do
    Task.start(fn -> MessagePersister.create(message, :jw316) end)
    Task.start(fn -> MessagePersister.create(message, :jw301) end)
    message
  end

  defp update_status(message, status) do
    Map.replace(message, :status, Atom.to_string(status))
  end
end
