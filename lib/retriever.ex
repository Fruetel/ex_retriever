defmodule Retriever do

  @moduledoc false

  require Logger

  def fetch(%Link{destination_url: url}) do
    Logger.info "Fetching #{url}"
    url
    |> HTTPotion.get(options())
    |> parse_response
    |> Map.put(:url, url)
    |> publish
  end

  defp publish(document) do
    Logger.debug "Publishing"
    primary_content_type = Document.primary_content_type(document)
    secondary_content_type = Document.secondary_content_type(document)
    routing_key = "retrieved.#{primary_content_type}.#{secondary_content_type}"
    :ok = Publisher.publish("documents", routing_key, document)
    document
  end

  defp parse_response(response) do
    Logger.info "Got response with status code #{response.status_code}"
    %Document{
      status_code: response.status_code,
      headers: response_headers(response),
      body: response.body
    }
  end

  defp response_headers(response) do
    response.headers
  end

  defp request_headers do
    [
      "User-Agent": Application.get_env(:ex_retriever, Retriever)[:user_agent]
    ]
  end

  defp options do
    [
      headers: request_headers(),
      timeout: get_integer_config(:timeout),
    ]
    |> IO.inspect
  end

  defp get_integer_config(key) do
    {value, _} = Integer.parse("#{Application.get_env(:ex_retriever, Retriever)[key]}")
    value
  end
end
