use Mix.Config

config :ex_retriever, Consumer,
  rabbitmq_url: System.get_env("RABBITMQ_URL")

config :ex_retriever, Retriever,
  timeout: System.get_env("TIMEOUT"),
  recv_timeout: System.get_env("RECV_TIMEOUT"),
  user_agent: System.get_env("USER_AGENT")

config :ex_retriever, Publisher,
  rabbitmq_url: System.get_env("RABBITMQ_URL")

config :logger,
  level: :info
