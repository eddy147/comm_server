defmodule CommServer.XmlCreator do
  import XmlBuilder
  alias CommServer.Messages.Message
  alias CommServer.Parser
  alias CommServer.Randomiser

  def create_xml(%Message{} = message, subtype, id) do
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
        elementHeader(message, id, ns_type, ns_subtype, message_code),
        elementClient(message, ns_type, ns_subtype),
        elementToegewezenProducten(message, ns_type, ns_subtype)
      ]
    )
  end

  defp elementHeader(%Message{} = message, id, ns_type, ns_subtype, message_code) do
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

  defp elementClient(%Message{} = message, ns_type, ns_subtype) do
    element(:"#{ns_subtype}:Client", [
      element(:"#{ns_subtype}:Bsn", Parser.getClientInfoByTag(message, "Bsn")),
      element(:"#{ns_subtype}:Geboortedatum", [
        element(:"#{ns_type}:Datum", Parser.getClientInfoByTag(message, "Geboortedatum/Datum"))
      ])
    ])
  end

  defp elementToegewezenProducten(%Message{} = message, ns_type, ns_subtype) do
    element(:"#{ns_subtype}:ToegewezenProducten", [
      element(:"#{ns_subtype}:ToegewezenProduct", [
        element(:"#{ns_subtype}:ToewijzingNummer", Randomiser.rand(10, :numeric))
      ])
    ])
  end
end
