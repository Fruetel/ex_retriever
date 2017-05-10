defmodule Retriever do

  @moduledoc false

  require Logger

  def get(url) do
    Logger.info "Retrieving #{url}"
    response = parse_response HTTPoison.get(url, request_headers, options)
    Map.put response, :url, url
  end

  defp parse_response({:ok, response}) do
    %Retriever.Document{
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
    []
  end
end
