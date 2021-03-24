%{
  attr: [
    "xmlns:ijw": "http://www.istandaarden.nl/ijw/3_0/basisschema/schema",
    "xmlns:jw315": "http://www.istandaarden.nl/ijw/3_0/jw315/schema"
  ],
  name: :bericht,
  value: [
    %{
      attr: [],
      name: :header,
      value: [
        %{attr: [], name: :bericht_code, value: ["446"]},
        %{attr: [], name: :bericht_versie, value: ["3"]},
        %{attr: [], name: :bericht_subversie, value: ["0"]},
        %{attr: [], name: :afzender, value: ["22227338"]},
        %{attr: [], name: :ontvanger, value: ["0344"]},
        %{
          attr: [],
          name: :bericht_identificatie,
          value: [
            %{attr: [], name: :identificatie, value: ["MC008896A559"]},
            %{attr: [], name: :dagtekening, value: ["2021-01-19"]}
          ]
        },
        %{
          attr: [],
          name: :xsd_versie,
          value: [
            %{attr: [], name: :basisschema_xsd_versie, value: ["1.2.0"]},
            %{attr: [], name: :bericht_xsd_versie, value: ["1.0.2"]}
          ]
        }
      ]
    },
    %{
      attr: [],
      name: :client,
      value: [
        %{attr: [], name: :bsn, value: ["999900006"]},
        %{
          attr: [],
          name: :geboortedatum,
          value: [%{attr: [], name: :datum, value: ["2000-01-01"]}]
        },
        %{attr: [], name: :geslacht, value: ["1"]},
        %{
          attr: [],
          name: :naam,
          value: [
            %{
              attr: [],
              name: :geslachtsnaam,
              value: [%{attr: [], name: :achternaam, value: ["Vries"]}]
            },
            %{attr: [], name: :voorletters, value: ["P"]}
          ]
        },
        %{attr: [], name: :gezagsdrager_bekend, value: ["1"]},
        %{
          attr: [],
          name: :aangevraagde_producten,
          value: [
            %{
              attr: [],
              name: :aangevraagd_product,
              value: [
                %{
                  attr: [],
                  name: :referentie_aanbieder,
                  value: ["88efe721359587"]
                },
                %{
                  attr: [],
                  name: :product,
                  value: [
                    %{attr: [], name: :categorie, value: ["45"]},
                    %{attr: [], name: :code, value: ["YS1U"]}
                  ]
                },
                %{
                  attr: [],
                  name: :toewijzing_ingangsdatum,
                  value: ["2021-01-01"]
                },
                %{
                  attr: [],
                  name: :omvang,
                  value: [
                    %{attr: [], name: :volume, value: ["87"]},
                    %{attr: [], name: :eenheid, value: ["83"]},
                    %{attr: [], name: :frequentie, value: ["4"]}
                  ]
                },
                %{
                  attr: [],
                  name: :verwijzer,
                  value: [
                    %{attr: [], name: :type, value: ["01"]},
                    %{attr: [], name: :naam, value: ["Utrecht"]}
                  ]
                },
                %{attr: [], name: :raamcontract, value: ["2"]}
              ]
            }
          ]
        }
      ]
    }
  ]
}
