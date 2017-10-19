use Mix.Config

config :ex_retriever, Consumer,
  rabbitmq_url: "amqp://guest:guest@localhost"

config :ex_retriever, Retriever,
  timeout: 10_000,
  recv_timeout: 20_000,
  user_agent: "Mozilla/5.0 (compatible; ExRetriever; +https://github.com/Fruetel/ex_retriever)"

config :ex_retriever, Publisher,
  rabbitmq_url: "amqp://guest:guest@localhost"
