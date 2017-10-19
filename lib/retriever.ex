defmodule Retriever do

  @moduledoc false

  require Logger

  def fetch(%Link{destination_url: url}) do
    Logger.info "Retrieving #{url}"
    url
    |> HTTPoison.get(request_headers(), options())
    |> parse_response
    |> Map.put(:url, url)
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
    [
      timeout: Application.get_env(:ex_retriever, Retriever)[:timeout],
      recv_timeout: Application.get_env(:ex_retriever, Retriever)[:recv_timeout]
    ]
  end
end
