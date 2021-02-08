defmodule CommServer.Messages.Repo.Migrations.AddMessagesTable do
  use Ecto.Migration

  def up do
    create table("message", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type :string,
      add :subtype :string,
      add :conversation_id :string,
      add :version_major :string,
      add :version_minor :string,
      add :institution :string,
      add :municipality :string,
      add :action :string,
      add :xml :string,
      add :xml_origin :string,
      add :status: :string

      timestamps
    end
  end

  def down do
    drop table("message")
  end
end
