defmodule CommServer.MessageCreator do
  alias CommServer.Messages.Message
  alias CommServer.MessagePersister
  alias CommServer.XmlCreator

  def upsert_message(%Message{} = message) do
    MessagePersister.upsert_message(message)
  end

  def create(request_message, :jw301) do
    id = Ecto.UUID.generate()

    %{
      request_message
      | id: id,
        conversation_id: id,
        action: nil,
        subtype: "JW301",
        xml: XmlCreator.create_xml(request_message, :jw301, id)
    }
    |> MessagePersister.upsert_message()
  end

  def create(%Message{} = jw315, :jw316) do
    id = Ecto.UUID.generate()

    %{
      jw315
      | id: id,
        conversation_id: jw315.conversation_id,
        action: nil,
        subtype: "JW316",
        xml: "<JW316/>"
    }
    |> MessagePersister.upsert_message()
  end
end
