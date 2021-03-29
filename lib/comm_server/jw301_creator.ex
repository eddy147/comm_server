defmodule CommServer.Jw301Creator do
  alias CommServer.Message
  alias CommServer.Randomiser
  alias CommServer.Randomiser

  @templates_path Path.expand("./templates", __DIR__)

  def create(%Message{type: "JW315"} = msg) do
    id = Randomiser.rand(:uuid)

    jw301 = %Message{
      uuid: id,
      type: "JW301",
      xml: render_xml(msg, id)
    }

    jw301
  end

  defp render_xml(%Message{} = msg, id) do
    sender = %{code: "415"}
    receiver = %{code: "100911"}
    client = %{date_of_birth: "2010-01-01", bsn: "1234567892"}
    message = %{id: "1662711"}
    date = %{today: "2021-03-30"}

    @templates_path
    |> Path.join("jw301.xml.eex")
    |> EEx.eval_file(
      sender: sender,
      receiver: receiver,
      client: client,
      message: message,
      date: date
    )
  end
end
