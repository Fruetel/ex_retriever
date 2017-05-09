defmodule RetrieverTest do
  use ExUnit.Case
  import Mock

  test "It gets a url" do
    http_response = %{
      status_code: 200,
      headers: [{"key", "value"}],
      body: "some body"
    }

    expected_result = %Retriever.Document{
      status_code: 200,
      headers: %{"key" => "value"},
      body: "some body",
      url: "http://www.example.com"
    }

    with_mock HTTPoison, [get: fn _ -> {:ok, http_response} end] do
      result = Retriever.get("http://www.example.com")
      assert expected_result == result
    end
  end
end
