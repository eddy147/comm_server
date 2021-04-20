defmodule CommServer.Message do
  defstruct uuid: "",
            conversation_uuid: "",
            type: "",
            action: "",
            version_major: 0,
            version_minor: 0,
            institution: "",
            municipality: "",
            xml: ""
end
