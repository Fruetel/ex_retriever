defmodule Consumer do
  use Tackle.Consumer,
    url: config[:url],
    exchange: config[:exchange],
    routing_key: config[:routing_key],
    service: config[:service]

  def handle_message(message) do
    IO.puts "A message arrived. Life is good!"

    IO.puts message
  end

  defp config do
    Application.get_env(:ex_retriever, Consumer)
  end
end
