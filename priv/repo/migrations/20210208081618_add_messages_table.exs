defmodule CommServer.Messages.Repo.Migrations.AddMessagesTable do
  use Ecto.Migration

  def up do
    create table("message", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string, size: 5
      add :subtype, :string, size: 10
      add :conversation_id, :uuid
      add :version_major, :numeric
      add :version_minor, :numeric
      add :institution, :string, size: 100
      add :municipality, :string, size: 100
      add :action, :string, size: 20
      add :xml, :text
      add :status, :string, size: 10

      timestamps
    end
  end

  def down do
    drop table("message")
  end
end
