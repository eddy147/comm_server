defmodule CommServerTest do
  use ExUnit.Case
  doctest CommServer

  test "greets the world" do
    assert CommServer.hello() == :world
  end
end
