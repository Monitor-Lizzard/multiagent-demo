defmodule MultiAgentDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :multiagent_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :gecko_one]

    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gecko_one, git: "https://github.com/Monitor-Lizzard/gecko_one.git"}
    ]
  end
end
