defmodule CommServer.Message do
  defstruct uuid: "",
            conversation_uuid: "",
            type: "",
            action: "",
            version_major: "",
            version_minor: "",
            institution: "",
            municipality: "",
            xml: ""
end
