defmodule RetrieverTest do
  use ExUnit.Case

  test "It gets a url" do
    result = Retriever.get("http://www.example.com")
    assert {:ok, :payload} == result
  end
end
