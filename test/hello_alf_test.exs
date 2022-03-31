defmodule HelloAlfTest do
  use ExUnit.Case
  doctest HelloAlf

  test "greets the world" do
    assert HelloAlf.hello() == :world
  end
end
