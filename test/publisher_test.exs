defmodule PublisherTest do

  use ExUnit.Case, async: false

  import Mock

  test "It publishes a document" do
    document = %{
      url: "http://example.com"
    }

    payload = "{\"url\":\"http://example.com\"}"

    with_mock Tackle, [publish: fn _, _ -> :ok end] do
      assert :ok = Publisher.publish(document)
      assert called Tackle.publish(payload, :_)
    end
  end
end
