defmodule ExRetrieverTest do
  use ExUnit.Case
  doctest ExRetriever

  test "it starts the required workers" do
    children = Supervisor.which_children(ExRetriever.Supervisor)
    assert 1 = Enum.count(children)
  end
end
