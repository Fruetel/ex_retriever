defmodule RetrieverTest do
  use ExUnit.Case
  import Mock

  test "It fetches a url" do
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

    with_mock HTTPoison, [get: fn _, _, _ -> {:ok, http_response} end] do
      result = Retriever.fetch(%Link{destination_url: "http://www.example.com"})
      assert expected_result == result
      assert called HTTPoison.get(
        "http://www.example.com",
        [{"user-agent", "Mozilla/5.0 (compatible; ExRetriever; +https://github.com/Fruetel/ex_retriever)"}],
        [
          timeout: 10000,
          recv_timeout: 20000
        ]
      )
    end
  end
end
