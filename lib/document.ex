defmodule Document do

  @moduledoc false

  require Logger

  defstruct [:url, :status_code, :headers, :body]

  def encode(%Document{headers: %{"Content-Type" => "image/jpeg"}} = document), do: encode_binary(document)
  def encode(%Document{headers: %{"Content-Type" => "image/png"}} = document), do: encode_binary(document)
  def encode(%Document{headers: %{"Content-Type" => "image/jpg"}} = document), do: encode_binary(document)
  def encode(%Document{headers: %{"Content-Type" => "image/gif"}} = document), do: encode_binary(document)
  def encode(document) do
    Logger.debug "Encoding standard document"
    Poison.encode!(document)
  end

  defp encode_binary(%Document{} = document) do
    Logger.debug "Encoding binary document"
    Map.merge(document, %{body: Base.encode64(document.body)})
    |> Poison.encode!
  end
end
