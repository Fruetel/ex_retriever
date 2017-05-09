defmodule ConsumerTest do
  use ExUnit.Case, async: false

  import Mock

  test "it handles a message" do
    url = "http://example.org"
    message = "{\"url\": \"#{url}\"}"

    document = %Retriever.Document{
      status_code: 200,
      headers: %{"content-type" => "text/html"},
      body: "Body",
      url: "http://example.org"
    }

    parsed_response = "{\"url\":\"http://example.org\",\"status_code\":200,\"headers\":{\"content-type\":\"text/html\"},\"body\":\"Body\"}"

    with_mock Retriever, [get: fn _ -> document end] do
      with_mock Publisher, [publish: fn _ -> :ok end] do
        assert :ok == Consumer.handle_message(message)
        assert called Retriever.get(url)
        assert called Publisher.publish(parsed_response)
      end
    end
  end
end
