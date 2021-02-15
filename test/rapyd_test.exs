defmodule RapydTest do
  use ExUnit.Case
  doctest Rapyd

  test "greets the world" do
    assert Rapyd.hello() == :world
  end
end
