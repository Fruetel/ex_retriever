defmodule Retriever do

  def get(url) do
    HTTPoison.get(url)
  end
end
