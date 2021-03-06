defmodule CommServerTest do
  use ExUnit.Case
  doctest CommServer
  import SweetXml

  test "greets the world" do
    IO.inspect(Mix.env())
    assert CommServer.hello() == :world
  end

  test "SweetXml" do
    xml =
      ~s(<jw315:Bericht xmlns:ijw="http://www.istandaarden.nl/ijw/3_0/basisschema/schema" xmlns:jw315="http://www.istandaarden.nl/ijw/3_0/jw315/schema">
    <jw315:Header>
      <jw315:BerichtCode>446</jw315:BerichtCode>
      <jw315:BerichtVersie>3</jw315:BerichtVersie>
      <jw315:BerichtSubversie>0</jw315:BerichtSubversie>
      <jw315:Afzender>22227338</jw315:Afzender>
      <jw315:Ontvanger>0344</jw315:Ontvanger>
      <jw315:BerichtIdentificatie>
        <ijw:Identificatie>MC008896A559</ijw:Identificatie>
        <ijw:Dagtekening>2021-01-19</ijw:Dagtekening>
      </jw315:BerichtIdentificatie>
      <jw315:XsdVersie>
        <ijw:BasisschemaXsdVersie>1.2.0</ijw:BasisschemaXsdVersie>
        <ijw:BerichtXsdVersie>1.0.2</ijw:BerichtXsdVersie>
      </jw315:XsdVersie>
    </jw315:Header>
    <jw315:Client>
      <jw315:Bsn>999900006</jw315:Bsn>
      <jw315:Geboortedatum>
        <ijw:Datum>2000-01-01</ijw:Datum>
      </jw315:Geboortedatum>
      <jw315:Geslacht>1</jw315:Geslacht>
      <jw315:Naam>
        <ijw:Geslachtsnaam>
          <ijw:Achternaam>Vries</ijw:Achternaam>
        </ijw:Geslachtsnaam>
        <ijw:Voorletters>P</ijw:Voorletters>
      </jw315:Naam>
      <jw315:GezagsdragerBekend>1</jw315:GezagsdragerBekend>
      <jw315:AangevraagdeProducten>
        <jw315:AangevraagdProduct>
          <jw315:ReferentieAanbieder>88efe721359587</jw315:ReferentieAanbieder>
          <jw315:Product>
            <ijw:Categorie>45</ijw:Categorie>
            <ijw:Code>YS1U</ijw:Code>
          </jw315:Product>
          <jw315:ToewijzingIngangsdatum>2021-01-01</jw315:ToewijzingIngangsdatum>
          <jw315:Omvang>
            <ijw:Volume>87</ijw:Volume>
            <ijw:Eenheid>83</ijw:Eenheid>
            <ijw:Frequentie>4</ijw:Frequentie>
          </jw315:Omvang>
          <jw315:Verwijzer>
            <ijw:Type>01</ijw:Type>
            <ijw:Naam>Utrecht</ijw:Naam>
          </jw315:Verwijzer>
          <jw315:Raamcontract>2</jw315:Raamcontract>
        </jw315:AangevraagdProduct>
        <jw315:AangevraagdProduct>
          <jw315:ReferentieAanbieder>99efe721359566</jw315:ReferentieAanbieder>
          <jw315:Product>
            <ijw:Categorie>54</ijw:Categorie>
          </jw315:Product>
          <jw315:ToewijzingIngangsdatum>2021-01-01</jw315:ToewijzingIngangsdatum>
        </jw315:AangevraagdProduct>
      </jw315:AangevraagdeProducten>
    </jw315:Client>
  </jw315:Bericht>)

    result =
      xml
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

    assert result == %{
             products: [
               %{
                 allocatedStartDate: '2021-01-01',
                 category: '45',
                 code: 'YS1U',
                 referenceSupplier: '88efe721359587',
                 size: %{frequency: '4', unity: '83', volume: '87'}
               },
               %{
                 allocatedStartDate: '2021-01-01',
                 category: '54',
                 code: nil,
                 referenceSupplier: '99efe721359566',
                 size: nil
               }
             ]
           }


    IO.inspect(xml |> parse())
  end
end
