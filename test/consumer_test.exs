defmodule ConsumerTest do
  use ExUnit.Case, async: false

  import Mock

  test "it handles a message" do
    url = "http://example.org"
    message = "{\"url\": \"#{url}\"}"

    http_response = %{
      status_code: 200,
      headers: [{"content-type", "text/html"}],
      body: "Body"
    }

    parsed_response = "{\"status_code\":200,\"headers\":{\"content-type\":\"text/html\"},\"body\":\"Body\"}"

    with_mock Retriever, [get: fn _ -> {:ok, http_response} end] do
      with_mock Publisher, [publish: fn _ -> :ok end] do
        assert :ok == Consumer.handle_message(message)
        assert called Retriever.get(url)
        assert called Publisher.publish(parsed_response)
      end
    end
  end
end
