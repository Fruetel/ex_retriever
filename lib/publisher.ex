defmodule Publisher do

  @moduledoc false

  require Logger

  def publish(document) do
    Logger.info "Publishing result"

    options = %{
      url: config[:url],
      exchange: config[:exchange],
      routing_key: config[:routing_key]
    }

    Tackle.publish(document, options)
  end

  defp config do
    Application.get_env(:ex_retriever, Publisher)
  end
end
