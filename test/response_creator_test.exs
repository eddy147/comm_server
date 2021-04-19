defmodule ResponseCreatorTest do
  use ExUnit.Case

  alias CommServer.Message
  alias CommServer.ResponseCreator

  @templates_path Path.expand("../lib/comm_server/templates", __DIR__)

  test "Test response for handling JW315" do
    expected =
    ~s(<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
    <s:Body xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <IndienenBerichtResponse xmlns="http://schemas.vecozo.nl/berichtuitwisseling/v3">
            <IndienenBerichtResult>
                <ConversatieId xmlns="http://schemas.vecozo.nl/berichtuitwisseling/messages/v3">ec13c028-2aa0-4d38-92a6-df12369c9d94</ConversatieId>
                <TraceerId xmlns="http://schemas.vecozo.nl/berichtuitwisseling/messages/v3">97a5bb39-76c0-47e5-8af2-3c9a103f9c39</TraceerId>
            </IndienenBerichtResult>
        </IndienenBerichtResponse>
    </s:Body>
</s:Envelope>)
    actual = ResponseCreator.create(%Message{
      type: "JW315",
      uuid: "97a5bb39-76c0-47e5-8af2-3c9a103f9c39",
      conversation_uuid: "ec13c028-2aa0-4d38-92a6-df12369c9d94"
    })

    IO.inspect(actual)

    assert expected == actual
  end
end
