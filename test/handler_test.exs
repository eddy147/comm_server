defmodule HandlerTest do
  import SweetXml
  use ExUnit.Case
  doctest CommServer.Handler
  alias CommServer.Parser

  import CommServer.Handler, only: [loadMessage: 1]

  test "Load JW315" do
    {:ok, soap_envelope} = File.read("./test/fixtures/IndienenBericht.xml")
    response = loadMessage(soap_envelope) |> Parser.strip_whitespace()

    stripped = response |> Parser.strip_namespace()

    assert "fc6d5c90-5630-4270-aba2-bc1be7936502" ==
             stripped |> xpath(~x[//ConversatieId/text()]s)
  end
end
