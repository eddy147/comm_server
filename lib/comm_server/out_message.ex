defmodule CommServer.OutMessage do
  use Ecto.Schema

  schema "out" do
    field :agb, :string, size: 8
    field :type, :string, size: 10
    field :version, :string, size: 10
    field :filename, :string
    timestamps()
  end
end
