defmodule MultiAgentDemo do
  @moduledoc """
  Documentation for `MultiAgentDemo`.
  """
  def research_topic(topic) do
    case MultiAgentDemo.Workflows.ResearchWorkflow.execute(topic) do
      {:ok, :completed} ->
        # Get results from state store or other storage
        {:ok, "Research completed"}
      {:error, reason} ->
        {:error, "Research failed: #{inspect(reason)}"}
    end
  end
end
