defmodule ExRetriever.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_retriever,
      version: "0.1.0",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:lager, :logger, :httpotion], mod: {ExRetriever, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpotion, "~> 3.1.0"},
      {:amqp_client, "~> 3.7.8", override: true},
      {:rabbit_common, "~> 3.7.8", override: true},
      {:ranch, "~> 1.6.2", override: true},
      {:ranch_proxy_protocol, "~> 2.1.1", override: true},
      {:lager, "~> 3.6.6", override: true},
      {:amqp, "~> 1.0"},
      {:credo, "~> 0.7", only: :dev},
      {:poison, "~> 3.0"},
      {:mock, "~> 0.2", only: :test}
    ]
  end
end
