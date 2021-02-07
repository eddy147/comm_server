defmodule CommServer.IncomingServer do
  use GenServer

  alias CommServer.Parser

  @name __MODULE__

  def start_link(_arg) do
    IO.puts("Starting the Incoming Handler ...")
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def process(message) do
    GenServer.call(@name, {:store, message})
  end

  # todo fetch messages from DB
  defp fetch_messages() do
    []
  end

  defp update_status(message, status) do
    loaded_status = Map.put(message.status, status, true)
    Map.put(message, :status, loaded_status)
  end

  # Callbacks GenServer
  def init(_state) do
    queue = fetch_messages()
    {:ok, queue}
  end

  def handle_call({:process, soap_envelope}, _from, queue) do
    message = soap_envelope |> Parser.parse() |> update_status(:stored)

    new_queue = [message | queue]
    {:reply, :ok, new_queue}
  end

end
