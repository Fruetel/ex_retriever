defmodule Consumer do
  use Tackle.Consumer,
    url: config[:url],
    exchange: config[:exchange],
    routing_key: config[:routing_key],
    service: config[:service]

  require Logger

  def handle_message(message) do
    Logger.info "Received URL: #{message}"

    message
    |> Retriever.get
    |> IO.inspect
  end

  defp config do
    Application.get_env(:ex_retriever, Consumer)
  end
end
