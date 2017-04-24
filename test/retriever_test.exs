defmodule RetrieverTest do
  use ExUnit.Case
  import Mock

  test "It gets a url" do
    with_mock HTTPoison, [get: fn _ -> {:ok, :payload} end] do
      result = Retriever.get("http://www.example.com")
      assert {:ok, :payload} == result
    end
  end
end
