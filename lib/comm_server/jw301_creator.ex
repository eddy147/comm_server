defmodule CommServer.Jw301Creator do
  import XmlBuilder

  alias CommServer.Message
  alias CommServer.Randomiser
  alias CommServer.Randomiser

  @ns_subtype "jw301"
  @ns_type "ijw"
  @code "436"

  def create(%Message{type: "JW315"} = msg) do
    id = Randomiser.rand(:uuid)
    xml = element_main(msg, id) |> generate()

    %Message{
      uuid: id,
      type: "JW301",
      xml: xml
    }
  end

  defp element_main(%Message{} = msg, id) do
    element(
      String.to_atom(@ns_subtype <> ":Bericht"),
      %{
        ("xmlns:" <> @ns_subtype) => "=http://www.istandaarden.nl/ijw/3_0/basisschema/schema",
        ("xmlns:" <> @ns_subtype) => "=http://www.istandaarden.nl/ijw/3_0/jw301/schema"
      },
      [
        element_header(msg, id),
        element_client(msg),
        element_products(msg)
      ]
    )
  end

  defp element_header(%Message{} = msg, id) do
    element(String.to_atom(@ns_subtype <> ":Header"), [
      element(String.to_atom(@ns_subtype <> ":BerichtCode"), @code),
      element(String.to_atom(@ns_subtype <> ":BerichtVersie"), msg.version_major),
      element(String.to_atom(@ns_subtype <> ":BerichtSubVersie"), msg.version_minor),
      element(String.to_atom(@ns_subtype <> ":Afzender"), msg.municipality),
      element(String.to_atom(@ns_subtype <> ":Ontvanger"), msg.institution),
      element_identification(id),
      element_xsd_version()
    ])
  end

  defp element_identification(id) do
    element(String.to_atom(@ns_subtype <> ":BerichtIdentificatie"), [
      element(String.to_atom(@ns_type <> ":Identificatie"), id),
      element(String.to_atom(@ns_type <> ":Dagtekening"), Date.utc_today() |> Date.to_string())
    ])
  end

  defp element_xsd_version() do
    element(String.to_atom(@ns_subtype <> ":XsdVersie"), [
      element(String.to_atom(@ns_type <> ":BasisschemaXsdVersie"), "1.0.0"),
      element(String.to_atom(@ns_type <> ":BerichtXsdVersie"), "1.0.0")
    ])
  end

  defp element_client(%Message{} = msg) do
    element(String.to_atom(@ns_subtype <> ":Client"), [
      element(String.to_atom(@ns_subtype <> ":Bsn"), "Bsn"),
      element(String.to_atom(@ns_subtype <> ":Geboortedatum"), [
        element(String.to_atom(@ns_type <> ":Datum"), "Birthdate"),
        element(
          String.to_atom(@ns_subtype <> ":ToegewezenProducten"),
          element(element_products(msg))
        )
      ])
    ])
  end

  defp element_products(%Message{} = msg) do
    [data] = Quinn.parse(msg.xml)
    products = data |> Quinn.find(:AangevraagdProduct)

    element_products = add_element_products(products, [])
    IO.inspect(element_products)
  end

  def add_element_products([], elements), do: elements

  def add_element_products([_p | tail], elements) do
    add_element_products(
      tail,
      elements ++
        element(String.to_atom(@ns_subtype <> ":ToegewezenProduct"), [
          element(
            String.to_atom(@ns_subtype <> ":ToewijzingNummer"),
            Randomiser.rand(6, :numeric)
          ),
          element(
            String.to_atom(@ns_subtype <> ":ReferentieAanbieder"),
            Randomiser.rand(16, :all)
          ),
          element(
            String.to_atom(@ns_subtype <> ":Product"),
            [
              element(
                String.to_atom(@ns_type <> ":Categorie"),
                "45"
              )
            ]
          )
        ])
    )
  end
end
