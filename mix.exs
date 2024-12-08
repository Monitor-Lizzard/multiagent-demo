defmodule MultiAgentDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :multiagent_demo,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :whisperer]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:whisperer,
       path: "/Users/oluwapelumisola-aremu/Documents/Work/monitor-lizard.nosync/whisperer"},
      {:uuid, "~> 1.1"}
    ]
  end
end
