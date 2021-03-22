defmodule CommServer.Message do
  defstruct uuid: "",
    conversation_uuid: "",
    institution: "",
    type: "",
    action: "",
    version_major: "",
    version_minor: "",
    xml: ""
end
