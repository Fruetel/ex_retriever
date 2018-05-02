use Mix.Config

config :ex_retriever, Consumer,
  rabbitmq_url: System.get_env("RABBITMQ_URL")

config :ex_retriever, Retriever,
  timeout: System.get_env("TIMEOUT") || 10_000,
  recv_timeout: System.get_env("RECV_TIMEOUT") || 20_0000,
  user_agent: System.get_env("USER_AGENT") || "Mozilla/5.0 (compatible; ExRetriever; +https://github.com/Fruetel/ex_retriever)"

config :ex_retriever, Publisher,
  rabbitmq_url: System.get_env("RABBITMQ_URL")

config :logger,
  level: System.get_env("LOG_LEVEL") || :debug
