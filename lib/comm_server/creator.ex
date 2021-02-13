defmodule CommServer.Creator do
  import XmlBuilder
  alias CommServer.Messages.Message
  alias CommServer.Messages.Repo

  def create(request_message, :jw301) do
    IO.puts("Creating #{Atom.to_string(:jw301)}")
    id = Ecto.UUID.generate()

    %{
      request_message
      | id: id,
        conversation_id: id,
        action: nil,
        subtype: "JW301",
        xml: create_xml(request_message, :jw301, id)
    }
  end

  def create(jw315, :jw316) do
    IO.puts("Creating #{Atom.to_string(:jw316)}")
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

  def upsert_message(%Message{} = message) do
    Repo.insert!(message, on_conflict: :nothing)
  end

  defp create_xml(%Message{} = message, subtype, id) do
    message_specifics = getMessageMessageSpecifics(subtype)
    ns_type = message_specifics[:ns_type]
    ns_subtype = message_specifics[:ns_subtype]
    message_code = message_specifics[:code]

    elementBericht(message, id, ns_type, ns_subtype, message_code)
    |> generate()
  end

  defp getMessageMessageSpecifics(atom) do
    message_specifics = [jw301: [code: 436, ns_type: "ijw", ns_subtype: "JW301"]]
    message_specifics[atom]
  end

  defp elementBericht(message, id, ns_type, ns_subtype, message_code) do
    element(
      :"#{ns_subtype}:Bericht",
      %{
        "xmlns:#{ns_type}": "http://www.istandaarden.nl/ijw/3_0/basisschema/schema",
        "xmlns:#{ns_subtype}": "http://www.istandaarden.nl/ijw/3_0/#{ns_subtype}/schema"
      },
      [
        elementHeader(message, id, ns_type, ns_subtype, message_code)
      ]
    )
  end

  defp elementHeader(message, id, ns_type, ns_subtype, message_code) do
    element(:"#{ns_subtype}:Header", [
      element(:"#{ns_subtype}:BerichtCode", message_code),
      element(:"#{ns_subtype}:BerichtVersie", message.version_major),
      element(:"#{ns_subtype}:BerichtSubVersie", message.version_minor),
      element(:"#{ns_subtype}:Afzender", message.municipality),
      element(:"#{ns_subtype}:Ontvanger", message.institution),
      elementBerichIdentificatie(id, ns_type, ns_subtype),
      elementXsdVersie(ns_type, ns_subtype)
    ])
  end

  defp elementBerichIdentificatie(id, ns_type, ns_subtype) do
    element(:"#{ns_subtype}:BerichtIdentificatie", [
      element(:"#{ns_type}:Identificatie", id),
      element(:"#{ns_type}:Dagtekening", Date.utc_today() |> Date.to_string())
    ])
  end

  defp elementXsdVersie(ns_type, ns_subtype) do
    element(:"#{ns_subtype}:XsdVersie", [
      element(:"#{ns_type}:BasisschemaXsdVersie", "1.0.0"),
      element(:"#{ns_type}:BerichtXsdVersie", "1.0.0")
    ])
  end
end
