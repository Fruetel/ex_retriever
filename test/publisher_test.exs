defmodule PublisherTest do

  use ExUnit.Case, async: false

  import Mock

  test "It publishes a document" do
    with_mock Tackle, [publish: fn _, _ -> :ok end] do
      assert :ok = Publisher.publish(:document)
      assert called Tackle.publish(:document, :_)
    end
  end
end
