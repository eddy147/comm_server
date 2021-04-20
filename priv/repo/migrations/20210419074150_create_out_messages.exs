defmodule CommServer.Repo.Migrations.CreateOutMessages do
  use Ecto.Migration

  def change do
    create table(:out) do
      add :agb, :string, size: 8
      add :type, :string, size: 10
      add :version, :string, size: 10
      add :filename, :string

      timestamps
    end
  end
end
