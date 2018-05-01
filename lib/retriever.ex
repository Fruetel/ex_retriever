defmodule Retriever do

  @moduledoc false

  require Logger

  def fetch(%Link{destination_url: url}) do
    Logger.info "Fetching #{url}"
    url
    |> HTTPoison.get(request_headers(), options())
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

  defp parse_response({:ok, response}) do
    %Document{
      status_code: response.status_code,
      headers: response_headers(response),
      body: response.body
    }
  end

  defp response_headers(response) do
    Map.new(response.headers)
  end

  defp request_headers do
    [
      {"user-agent", Application.get_env(:ex_retriever, Retriever)[:user_agent]}
    ]
  end

  defp options do
    [
      timeout: get_integer_config(:timeout),
      recv_timeout: get_integer_config(:recv_timeout)
    ]
  end

  defp get_integer_config(key) do
    {value, _} = Integer.parse("#{Application.get_env(:ex_retriever, Retriever)[key]}")
    value
  end
end
