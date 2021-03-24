defmodule CommServer.CreateJw301 do
  import XmlBuilder
  alias CommServer.Message
  alias CommServer.Randomiser
  alias CommServer.ParseJw315
  alias CommServer.NodeFinder
  alias CommServer.Randomiser

  @ns_subtype "jw301"
  @ns_type "ijw"
  @code "436"

  def create(%Message{type: "JW315"} = msg) do
    id = Randomiser.rand(:uuid)
    element_main(msg, id) |> generate()
  end

  defp element_main(%Message{} = msg, id) do
    element(
      String.to_atom(@ns_subtype <> ":Bericht"),
      %{
        "xmlns:" <> @ns_subtype => "=http://www.istandaarden.nl/ijw/3_0/basisschema/schema",
        "xmlns:" <> @ns_subtype => "=http://www.istandaarden.nl/ijw/3_0/jw301/schema"
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
        element(String.to_atom(@ns_subtype <> ":ToegewezenProducten"),
          element(element_products(msg))
        )
      ])
    ])
  end

  defp element_products(%Message{} = msg) do
    [data] = ParseJw315.to_map(msg.xml)
    products = data |> NodeFinder.find(:AangevraagdProduct)
    add_element_product(products, [])
  end

  defp add_element_product(products, elements) do
    Enum.reduce(products, [], fn (p, _acc) ->
      elements ++ element(String.to_atom(@ns_subtype <> ":ToegewezenProduct"), [
        element(String.to_atom(@ns_subtype <> ":ToewijzingNummer", Randomiser.rand(6, :numeric))),
        element(String.to_atom(@ns_subtype <> ":ReferentieAanbieder", Randomiser.rand(16, :all))),
        add_element_product_info(p)
      ])
    end)
  end

  defp add_element_product_info(product) do
    if (product)
  end
end
