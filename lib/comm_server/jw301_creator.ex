defmodule CommServer.Jw301Creator do
  alias CommServer.Message
  alias CommServer.Parser
  alias CommServer.Randomiser

  @templates_path Path.expand("./templates", __DIR__)

  def create(%Message{type: "JW315"} = msg) do
    id = Randomiser.rand(:uuid)

    jw301 = %Message{
      uuid: id,
      type: "JW301",
      xml: render_xml(msg)
    }

    jw301
  end

  defp render_xml(%Message{type: "JW315"} = msg) do
    products = Parser.products_flat_map(msg)

    jw301 = %{
      afzender: Parser.find(msg, :ontvanger),
      dagtekening: Date.utc_today() |> Date.to_string(),
      identificatie: Randomiser.rand(14, :all),
      ontvanger: Parser.find(msg, :afzender),
      client: %{
        bsn: Parser.find(msg, :bsn),
        geboortedatum: Parser.find(msg, :datum),
        achternaam: Parser.find(msg, :achternaam),
        voorvoegsel: Parser.find(msg, :voorvoegsel),
        voorletters: Parser.find(msg, :voorletters),
        voornamen: Parser.find(msg, :voornamen),
        products: products
      }
    }

    @templates_path
    |> Path.join("jw301.xml.eex")
    |> EEx.eval_file(jw301: jw301)
  end
end
