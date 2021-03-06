defmodule CommServer.Jw301Creator do
  import XmlBuilder
  import SweetXml
  alias CommServer.Messages.Message
  alias CommServer.Parser
  alias CommServer.Randomiser

  def create(jw315, :jw301) do
    id = Ecto.UUID.generate()

    %{
      jw315
      | id: id,
        conversation_id: id,
        action: nil,
        subtype: "JW301",
        xml: create_xml(jw315, id)
    }
  end

  def create_xml(%Message{subtype: "JW315"} = jw315, id) do
    elementBericht(jw315, id)
    |> generate()
  end

  defp elementBericht(%Message{subtype: "JW315"} = jw315, id) do
    element(
      :"jw301:Bericht",
      %{
        "xmlns:ijw": "http://www.istandaarden.nl/ijw/3_0/basisschema/schema",
        "xmlns:jw301": "http://www.istandaarden.nl/ijw/3_0/jw301/schema"
      },
      [
        elementHeader(jw315, id),
        elementClient(jw315),
        elementToegewezenProducten(jw315)
      ]
    )
  end

  defp elementHeader(%Message{subtype: "JW315"} = jw315, id) do
    element(:"jw301:Header", [
      element(:"jw301:BerichtCode", "436"),
      element(:"jw301:BerichtVersie", jw315.version_major),
      element(:"jw301:BerichtSubVersie", jw315.version_minor),
      element(:"jw301:Afzender", jw315.municipality),
      element(:"jw301:Ontvanger", jw315.institution),
      elementBerichIdentificatie(id),
      elementXsdVersie()
    ])
  end

  defp elementBerichIdentificatie(id) do
    element(:"jw301:BerichtIdentificatie", [
      element(:"ijw:Identificatie", id),
      element(:"ijw:Dagtekening", Date.utc_today() |> Date.to_string())
    ])
  end

  defp elementXsdVersie() do
    element(:"jw301:XsdVersie", [
      element(:"ijw:BasisschemaXsdVersie", "1.0.0"),
      element(:"ijw:BerichtXsdVersie", "1.0.0")
    ])
  end

  defp elementClient(%Message{} = jw315) do
    element(:"jw301:Client", [
      element(:"jw301:Bsn", xpath(jw315.xml, ~x"//jw315:Client/jw315:Bsn/text()"s)),
      element(:"jw301:Geboortedatum", [
        element(
          :"ijw:Datum",
          xpath(jw315.xml, ~x"//jw315:Client/jw315:Geboortedatum/ijw:Datum/text()"s)
        )
      ]),
      element(:"jw301:Geslacht", xpath(jw315.xml, ~x"//jw315:Client/jw315:Geslacht/text()"s)),
      element(
        :"jw301:Naam",
        xpath(jw315.xml, ~x"//jw315:Client/jw315:Naam", [
          element(:"ijw:Geslachtsnaam", [
            element(
              :"ijw:Achternaam",
              xpath(
                jw315.xml,
                ~x"//jw315:Client/jw315:Naam/jw315:Geslachtsnaam/jw315:Achternaam/text()"s
              )
            ),
            element(
              :"ijw:Voorvoegsel",
              xpath(
                jw315.xml,
                ~x"//jw315:Client/jw315:Naam/jw315:Geslachtsnaam/jw315:Voorvoegsel/text()"s
              )
            )
          ])
        ])
      )
    ])
  end

  defp elementToegewezenProducten(%Message{subtype: "JW315"} = jw315) do
    element(:"jw301:ToegewezenProducten", addElementsToegewezenProduct(jw315))
  end

  defp addElementsToegewezenProduct(%Message{subtype: "JW315"} = jw315) do
    products = fetchProducts(jw315)
    Enum.map(products.products, fn p -> createElementToegewezenProduct(p) end)
  end

  defp createElementToegewezenProduct(%{} = product) do
      element(:"jw301:ToegewezenProduct", [
        element(:"jw301:ToewijzingNummer", Randomiser.rand(10, :numeric))
      ])
  end

  defp fetchProducts(%Message{subtype: "JW315"} = jw315) do
    jw315.xml
    |> xmap(
      products: [
        ~x"//jw315:AangevraagdProduct"l,
        referenceSupplier: ~x"./jw315:ReferentieAanbieder/text()",
        category: ~x"./jw315:Product/ijw:Categorie/text()",
        code: ~x"./jw315:Product/ijw:Code/text()"o,
        allocatedStartDate: ~x"./jw315:ToewijzingIngangsdatum/text()",
        size: [
          ~x"./jw315:Omvang"o,
          volume: ~x"./ijw:Volume/text()",
          unity: ~x"./ijw:Eenheid/text()",
          frequency: ~x"./ijw:Frequentie/text()"
        ]
      ]
    )
  end
end
