defmodule CommServer.File do
  def read(file) do
    case File.read(file) do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
  end
end
