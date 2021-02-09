defmodule CommServer.MessageHandler do
  use GenServer

  alias CommServer.Parser
  alias CommServer.Messages.Repo

  @name __MODULE__

  def start_link(_arg) do
    IO.puts("Starting the Message Handler ...")
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def process(message) do
    GenServer.call(@name, {:parse, message})
  end

  # todo fetch messages from DB
  defp fetch_messages() do
    []
  end

  defp update_status(message, status) do
    Map.put(message, :status, Atom.to_string(status))
  end

  defp upsert_message(changeset) do
    Repo.insert!(changeset, on_conflict: :nothing)
  end

  # Callbacks GenServer
  def init(_state) do
    queue = fetch_messages()
    {:ok, queue}
  end

  def handle_call({:parse, soap_envelope}, _from, queue) do
    message =
      soap_envelope
      |> Parser.parse()
      |> update_status(:parsed)
      |> upsert_message()
      |> update_status(:created)

    new_queue = [message | queue]
    {:reply, message, new_queue}
  end
end
