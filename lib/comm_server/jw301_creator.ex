defmodule CommServer.Jw301Creator do
  import XmlBuilder
  alias CommServer.Messages.Message
  alias CommServer.Parser
  alias CommServer.Randomiser
  alias CommServer.XmlSpecifics

  def create(request_message, :jw301) do
    id = Ecto.UUID.generate()

    %{
      request_message
      | id: id,
        conversation_id: id,
        action: nil,
        subtype: "JW301",
        xml: create_xml(request_message, id)
    }
    |> Persister.upsert_message()
  end
  def create_xml(%Message{} = request_message, id) do
    specifics = XmlSpecifics.get(:jw301)
    elementBericht(request_message, id, specifics)
    |> generate()
  end

  defp elementBericht(request_message, id, specifics) do
    element(
      :"#{specifics.ns1}:Bericht",
      %{
        "xmlns:#{specifics.ns2}": "http://www.istandaarden.nl/ijw/3_0/basisschema/schema",
        "xmlns:#{specifics.ns1}": "http://www.istandaarden.nl/ijw/3_0/#{specifics.ns1}/schema"
      },
      [
        elementHeader(request_message, id, specifics),
        elementClient(request_message, specifics),
        elementToegewezenProducten(request_message, specifics)
      ]
    )
  end

  defp elementHeader(%Message{} = request_message, id, specifics) do
    element(:"#{specifics.ns1}:Header", [
      element(:"#{specifics.ns1}:BerichtCode", specifics.code),
      element(:"#{specifics.ns1}:BerichtVersie", request_message.version_major),
      element(:"#{specifics.ns1}:BerichtSubVersie", request_message.version_minor),
      element(:"#{specifics.ns1}:Afzender", request_message.municipality),
      element(:"#{specifics.ns1}:Ontvanger", request_message.institution),
      elementBerichIdentificatie(id, specifics),
      elementXsdVersie(specifics)
    ])
  end

  defp elementBerichIdentificatie(id, specifics) do
    element(:"#{specifics.ns1}:BerichtIdentificatie", [
      element(:"#{specifics.ns2}:Identificatie", id),
      element(:"#{specifics.ns2}:Dagtekening", Date.utc_today() |> Date.to_string())
    ])
  end

  defp elementXsdVersie(
    specifics) do
    element(:"#{specifics.ns1}:XsdVersie", [
      element(:"#{specifics.ns2}:BasisschemaXsdVersie", "1.0.0"),
      element(:"#{specifics.ns2}:BerichtXsdVersie", "1.0.0")
    ])
  end

  defp elementClient(%Message{} = request_message,
  specifics) do
    element(:"#{specifics.ns1}:Client", [
      element(:"#{specifics.ns1}:Bsn", Parser.getClientInfoByTag(request_message, "Bsn")),
      element(:"#{specifics.ns1}:Geboortedatum", [
        element(:"#{specifics.ns2}:Datum", Parser.getClientInfoByTag(request_message, "Geboortedatum/Datum"))
      ])
    ])
  end

  defp elementToegewezenProducten(%Message{} = request_message,
  specifics) do
    products = fetchProducts(request_message)

    element(:"#{specifics.ns1}:ToegewezenProducten", [
      element(:"#{specifics.ns1}:ToegewezenProduct", [
        element(:"#{specifics.ns1}:ToewijzingNummer", Randomiser.rand(10, :numeric))
      ])
    ])
  end

  defp fetchProducts(%Message{subtype: "JW315"} = request_message) do
    products = Parser.fetchProducts(request_message)
    products
  end
end
