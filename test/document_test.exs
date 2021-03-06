defmodule DocumentTest do

  use ExUnit.Case

  test "It encodes a text document" do
    document = %Document{
      status_code: 200,
      url: "http://www.example.com",
      headers: %{"Content-Type" => "text/html"},
      body: "Some Body"
    }

    expected_result = "{\"url\":\"http://www.example.com\",\"status_code\":200,\"headers\":{\"Content-Type\":\"text/html\"},\"body\":\"Some Body\"}"
    assert expected_result == Document.encode(document)
  end

  test "It encodes an image document" do
    document = %Document{
      status_code: 200,
      url: "http://www.example.com",
      headers: %{"Content-Type" => "image/jpeg"},
      body: "Binary data"
    }

    expected_result = "{\"url\":\"http://www.example.com\",\"status_code\":200,\"headers\":{\"Content-Type\":\"image/jpeg\"},\"body\":\"QmluYXJ5IGRhdGE=\"}"
    assert expected_result == Document.encode(document)
  end

  test "It determines the primary content type" do
    document = %Document{
      status_code: 200,
      url: "http://www.example.com",
      headers: %{"Content-Type" => "image/jpeg"},
      body: "Binary data"
    }

    assert "image" == Document.primary_content_type(document)
  end

  test "It determines the secondary content type" do
    document = %Document{
      status_code: 200,
      url: "http://www.example.com",
      headers: %{"Content-Type" => "image/jpeg"},
      body: "Binary data"
    }

    assert "jpeg" == Document.secondary_content_type(document)

    document = %Document{
      status_code: 200,
      url: "http://www.example.com",
      headers: %{"Content-Type" => "text/html; charset=UTF-8"},
      body: "Some Body"
    }

    assert "html" == Document.secondary_content_type(document)
  end

  test "It reports primary and secondary_content_type as unknown when header is missing" do
    document = %Document{
      status_code: 200,
      url: "http://www.example.com",
      headers: %{},
      body: "Binary data"
    }

    assert "unknown" == Document.primary_content_type(document)
    assert "unknown" == Document.secondary_content_type(document)
  end
end
