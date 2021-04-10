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
      afzender: Parser.get_value(msg, :ontvanger),
      dagtekening: Date.utc_today() |> Date.to_string(),
      identificatie: Randomiser.rand(14, :all),
      ontvanger: Parser.get_value(msg, :afzender),
      client: %{
        bsn: Parser.get_value(msg, :bsn),
        geboortedatum: Parser.get_value(msg, :datum),
        achternaam: Parser.get_value(msg, :achternaam),
        voorvoegsel: Parser.get_value(msg, :voorvoegsel),
        voorletters: Parser.get_value(msg, :voorletters),
        voornamen: Parser.get_value(msg, :voornamen),
        products: products
      }
    }

    IO.inspect(jw301)

    @templates_path
    |> Path.join("jw301.xml.eex")
    |> EEx.eval_file(jw301: jw301)
  end
end
