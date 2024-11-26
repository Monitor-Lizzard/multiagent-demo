defmodule MultiAgentDemoTest do
  use ExUnit.Case
  doctest MultiAgentDemo

  test "greets the world" do
    assert MultiAgentDemo.hello() == :world
  end
end
