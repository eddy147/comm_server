defmodule CommServer.ResponseCreator do
  import XmlBuilder
  alias CommServer.Message

  def create(%Message{action: "VerzoekToewijzing"} = message) do
    element("s:Envelope", %{"xmlns:s": "http://schemas.xmlsoap.org/soap/envelope/"}, [
      element(
        "s:Body",
        %{
          "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
          "xmlns:xsd": "http://www.w3.org/2001/XMLSchema"
        },
        [
          element(
            :IndienenBerichtResponse,
            %{xmlns: "http://schemas.vecozo.nl/berichtuitwisseling/v3"},
            [
              element(:IndienenBerichtResult, [
                element(
                  :ConversatieId,
                  %{xmlns: "http://schemas.vecozo.nl/berichtuitwisseling/messages/v3"},
                  message.conversation_id
                ),
                element(
                  :TraceerId,
                  %{xmlns: "http://schemas.vecozo.nl/berichtuitwisseling/messages/v3"},
                  message.id
                )
              ])
            ]
          )
        ]
      )
    ])
    |> generate
  end
end
