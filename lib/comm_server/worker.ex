defmodule CommServer.Worker do
  use GenServer
  import Ecto
  alias CommServer.Finder
  alias CommServer.Updater

  # Client
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def list() do
    GenServer.call(__MODULE__, {:list})
  end

  def push(message) do
    GenServer.cast(__MODULE__, {:push, message})
  end

  def process(id) do
    GenServer.cast(__MODULE__, {:process, id})
  end

  # Server
  def handle_call({:list}, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, message}, state) do
    new_message = %{
      message: message,
      processed: false,
      id: Ecto.UUID.generate()
    }

    new_state = state ++ [new_message]
    {:noreply, new_state}
  end

  def handle_cast({:process, id}, state) do
    message = Finder.fetch(state, id)
    new_state = Updater.setProcessed(state, message, true)
    {:noreply, new_state}
  end

  def init(:ok) do
    {:ok, []}
  end
end
