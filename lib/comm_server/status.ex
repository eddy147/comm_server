defmodule CommServer.Status do
  defstruct loaded: false,
            processed: false,
            return_message_received: false,
            return_message_sent: false
end
