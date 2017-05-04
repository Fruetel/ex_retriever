defmodule Consumer do

  @moduledoc false

  use Tackle.Consumer,
    url: config[:url],
    exchange: config[:exchange],
    routing_key: config[:routing_key],
    service: config[:service]

  require Logger

  def handle_message(message) do
    Logger.info "Received message: #{message}"

    message
    |> parse_message
    |> extract_url
    |> Retriever.get
    |> parse_response
    |> Publisher.publish
  end

  defp parse_response({:ok, response}) do
    Poison.encode! %{
      status_code: response.status_code,
      headers: headers(response),
      body: response.body
    }
  end

  defp config do
    Application.get_env(:ex_retriever, Consumer)
  end

  defp headers(response) do
    Map.new(response.headers)
  end

  defp parse_message(message) do
    message |> Poison.decode!(as: %Consumer.Message{})
  end

  defp extract_url(%Consumer.Message{url: url}) do
    url
  end
end
