defmodule HandlerTest do
  import SweetXml
  use ExUnit.Case
  doctest CommServer.MessageHandler
  alias CommServer.Parser
  alias CommServer.MessageHandler

  test "Process JW315" do
    {:ok, soap_envelope} = File.read("./test/fixtures/IndienenBericht.xml")

    message =
      soap_envelope
      |> MessageHandler.process()

      assert "VerzoekToewijzing" == message.action
      assert "fc6d5c90-5630-4270-aba2-bc1be7936502" == message.conversation_id
      assert "22227338" == message.institution
      assert "0344" = message.municipality
      assert true == message.status.processed
      assert "JW315" == message.subtype
      assert "fc6d5c90-5630-4270-aba2-bc1be7936502" == message.trace_id
      assert "JW" == message.type
      assert "3" == message.version_major
      assert "0" == message.version_minor
  end
end
