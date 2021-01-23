defmodule CommServer.Updater do
  alias CommServer.Finder

  def setProcessed(list, message, processed) do
    processed_message = %{message | processed: processed}

    list
    |> Enum.map(fn x ->
      if Finder.is_id?(x, message.id) do
        processed_message
      else
        x
      end
    end)
  end
end
