defmodule Document do

  @moduledoc false

  require Logger

  defstruct [:url, :status_code, :headers, :body]

  def encode(%Document{headers: %{"Content-Type" => _content_type}} = document) do
    if  primary_content_type(document) == "text" do
      Logger.debug "Encoding text document"
      try do
        Poison.encode!(document)
      rescue
        FunctionClauseError -> "Error encoding text document"
      end
    else
      Logger.debug "Encoding binary document"
      encode_binary(document)
    end
  end
  def encode(document) do
    Logger.debug "Encoding document without content type header"
    Poison.encode!(document)
  end

  def primary_content_type(%Document{headers: %{"Content-Type" => content_type}}) do
    content_type
    |> String.split("/")
    |> Enum.at(0)
  end
  def primary_content_type(%Document{}) do
    "unknown"
  end

  def secondary_content_type(%Document{headers: %{"Content-Type" => content_type}}) do
    content_type
    |> String.split("/")
    |> Enum.at(1)
    |> String.split(";")
    |> Enum.at(0)
  end
  def secondary_content_type(%Document{}) do
    "unknown"
  end


  defp encode_binary(%Document{} = document) do
    Logger.debug "Encoding binary document"
    Map.merge(document, %{body: Base.encode64(document.body)})
    |> Poison.encode!
  end

end
