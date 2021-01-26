defmodule CommServer.Finder do
  def fetch(list, id) do
    Enum.find(list, nil, fn m -> m.id == id end)
  end

  def is_id?(x, id), do: x.id == id
end
