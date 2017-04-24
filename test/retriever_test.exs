defmodule RetrieverTest do
  use ExUnit.Case

  test "It fetches a url" do
    result = Retriever.retrieve("http://www.example.com")
    assert {:ok, :payload} == result
  end
end
