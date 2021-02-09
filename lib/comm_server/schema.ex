defmodule CommServer.Schema do
  @moduledoc "Ecto Schema Helpers"

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key {:id, :binary_id, autogenerate: false}
      @foreign_key_type :binary_id
    end
  end
end
