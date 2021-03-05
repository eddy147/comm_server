defmodule CommServerTest do
  use ExUnit.Case
  doctest CommServer

  test "greets the world" do
    IO.inspect(Mix.env())
    assert CommServer.hello() == :world
  end
end
