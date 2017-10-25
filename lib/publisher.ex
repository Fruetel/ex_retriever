defmodule Publisher do

  require Logger

  use GenServer
  use AMQP

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :publisher)
  end

  def init(_opts) do
    {:ok, conn} = Connection.open(Application.get_env(
      :ex_retriever, Publisher)[:rabbitmq_url])
    {:ok, channel} = Channel.open(conn)
    {:ok, [channel: channel]}
  end

  def publish(exchange, routing_key, %Document{} = document) do
    GenServer.cast(:publisher, {:publish, exchange, routing_key, document})
  end

  def handle_cast({:publish, exchange, routing_key, %Document{} = document}, state) do
    Logger.debug "Publishing to #{exchange} with routing key #{routing_key}"
    payload = Document.encode(document)
    Basic.publish(state[:channel], exchange, routing_key, payload)
    {:noreply, state}
  end

end
