defmodule CommServer.Status do
  defstruct processed: false,
            return_message_received: false,
            return_message_sent: false
end
