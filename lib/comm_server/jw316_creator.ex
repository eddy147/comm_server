defmodule CommServer.Jw316Creator do

  def create(%Message{subtype: "JW315"} = jw315) do
    id = Ecto.UUID.generate()

    %{
      jw315
      | id: id,
        conversation_id: jw315.conversation_id,
        action: nil,
        subtype: "JW316",
        xml: "<JW316/>"
    }
  end
end
