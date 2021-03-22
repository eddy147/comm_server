defmodule CommServer.Persister do
  alias CommServer.Message

  def save(%Message{} = message) do
    # save to disk
  end
end
