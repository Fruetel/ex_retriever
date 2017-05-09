defmodule Publisher do

  @moduledoc false

  require Logger

  def publish(document) do
    Logger.info "Publishing result for #{document.url}"

    options = %{
      url: config[:url],
      exchange: config[:exchange],
      routing_key: config[:routing_key]
    }

    payload = Poison.encode!(document)
    Tackle.publish(payload, options)
  end

  defp config do
    Application.get_env(:ex_retriever, Publisher)
  end
end
