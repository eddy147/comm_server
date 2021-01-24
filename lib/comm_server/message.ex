defmodule CommServer.Message do
  defstruct type: "",
            subtype: "",
            trace_id: "",
            conversation_id: "",
            version_major: "",
            version_minor: "",
            institution: "",
            municipality: "",
            xml: "",
            status: CommServer.Status
end
