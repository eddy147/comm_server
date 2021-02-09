defmodule CommServer.Messages.Message do
  use Ecto.Schema
  use CommServer.Schema

  schema "message" do
    field(:type, :string)
    field(:subtype, :string)
    field(:conversation_id, Ecto.UUID)
    field(:version_major, :integer)
    field(:version_minor, :integer)
    field(:institution, :string)
    field(:municipality, :string)
    field(:action, :string)
    field(:xml, :string)
    field(:status, :string)

    timestamps()
  end
end
