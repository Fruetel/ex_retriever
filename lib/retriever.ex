defmodule Retriever do

  @moduledoc false

  require Logger

  def get(url) do
    Logger.info "Retrieving #{url}"
    response = parse_response HTTPoison.get(url)
    Map.put response, :url, url
  end

  defp parse_response({:ok, response}) do
    %Retriever.Document{
      status_code: response.status_code,
      headers: headers(response),
      body: response.body
    }
  end

  defp headers(response) do
    Map.new(response.headers)
  end
end
