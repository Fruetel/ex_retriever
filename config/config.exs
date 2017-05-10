use Mix.Config

config :ex_retriever, Consumer,
  url: System.get_env("RABBITMQ_URL") || "amqp://localhost",
  exchange: System.get_env("INCOMING_EXCHANGE") || "urls",
  routing_key: System.get_env("INCOMING_ROUTING_KEY") || "requested",
  service: System.get_env("SERVICE_NAME") || "ex_retriever"

config :ex_retriever, Retriever,
  user_agent: System.get_env("HTTP_USER_AGENT") || "Mozilla/5.0 (compatible; ExRetriever; +https://github.com/Fruetel/ex_retriever)",
  timeout: System.get_env("HTTP_CONNECT_TIMEOUT") || 10000,
  recv_timeout: System.get_env("HTTP_RECV_TIMEOUT") || 20000

config :ex_retriever, Publisher,
  url: System.get_env("RABBITMQ_URL") || "amqp://localhost",
  exchange: System.get_env("OUTGOING_EXCHANGE") || "documents",
  routing_key: System.get_env("OUTGOING_ROUTING_KEY") || "unprocessed"
