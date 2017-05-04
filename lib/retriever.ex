defmodule Retriever do

  @moduledoc false

  require Logger

  def get(url) do
    Logger.info "Retrieving #{url}"
    HTTPoison.get(url)
  end
end
