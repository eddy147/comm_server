defmodule CommServer.Persister do
  alias CommServer.Message
  alias CommServer.OutMessage
  alias CommServer.Repo

  require Logger

  @out_file_path Path.expand("../../out/", __DIR__)

  def save(%Message{} = msg) do
    IO.inspect(msg)
    out_message = %OutMessage{
      agb: msg.institution,
      type: msg.type,
      version: Integer.to_string(msg.version_major) <> "." <> Integer.to_string(msg.version_minor),
      filename: @out_file_path <> msg.institution <> "_" <> msg.type <> ".xml"
    }

    save_to_db(out_message)
    # save_to_disk(out_message, msg.xml)
  end

  def save_to_db(%OutMessage{} = msg) do
    case Repo.insert(msg) do
      {:ok, _} -> {:ok}
      {:error, changeset} -> raise "inspect #{changeset.errors}"
    end
  end

  def save_to_disk(%OutMessage{} = msg, xml) do
    IO.inspect("Save file to #{msg.filename}")
    File.write(@out_file_path <> msg.filename, xml)
  end
end
