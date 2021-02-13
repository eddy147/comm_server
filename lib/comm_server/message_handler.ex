defmodule CommServer.MessageHandler do
  use GenServer

  alias CommServer.Parser
  alias CommServer.Messages.Repo
  alias CommServer.Creator
  alias CommServer.Messages.Message

  @name __MODULE__

  def start_link(_arg) do
    IO.puts("Starting the Message Handler ...")
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def process(soap_envelope) do
    GenServer.call(@name, {:process, soap_envelope})
  end

  def create_answer_messages(request_message) when request_message.subtype in ["JW315"] do
    GenServer.cast(@name, {:create_answer_messages, request_message})
  end

  # todo fetch messages from DB
  defp fetch_messages() do
    []
  end

  defp update_status(message, status) do
    Map.replace!(message, :status, Atom.to_string(status))
  end

  defp upsert_message(%Message{} = changeset) do
    Creator.upsert_message(changeset)
  end

  # Callbacks GenServer
  def init(_state) do
    {:ok, fetch_messages()}
  end

  def handle_call({:process, soap_envelope}, _from, state) do
    message =
      soap_envelope
      |> Parser.parse()
      |> upsert_message()
      |> update_status(:processed)

    {:reply, message, [state] ++ message}
  end

  def handle_cast({:create_answer_messages, %Message{subtype: "JW315"} = message}, state) do
    jw301 = Creator.create(message, :jw301) |> upsert_message()
    jw316 = Creator.create(message, :jw316) |> upsert_message()
    {:noreply, [state] ++ [jw301, jw316]}
  end
end
