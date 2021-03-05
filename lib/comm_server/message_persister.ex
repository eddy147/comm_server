defmodule CommServer.MessagePersister do
  alias CommServer.Messages.Message
  alias CommServer.Messages.Repo

  def upsert_message(%Message{} = message) do
    Repo.insert!(message, on_conflict: :replace_all, conflict_target: :id)
  end
end
