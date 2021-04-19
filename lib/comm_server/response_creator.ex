defmodule CommServer.ResponseCreator do
  alias CommServer.Message

  @templates_path Path.expand("./templates", __DIR__)

  def create(%Message{type: "JW315"} = msg) do
    @templates_path
    |> Path.join("jw315_response.xml.eex")
    |> EEx.eval_file(msg: msg)
  end
end
