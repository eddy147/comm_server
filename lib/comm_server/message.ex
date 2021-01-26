defmodule CommServer.Message do
  defstruct type: "",
            subtype: "",
            trace_id: "",
            conversation_id: "",
            version_major: "",
            version_minor: "",
            institution: "",
            municipality: "",
            action: "",
            xml: "",
            xml_origin: "",
            status: CommServer.Status

  @spec constants :: %{ACTION_ALLOCATION_REQUEST: <<_::136>>}
  def constants,
    do: %{
      ACTION_ALLOCATION_REQUEST: "VerzoekToewijzing"
    }
end
