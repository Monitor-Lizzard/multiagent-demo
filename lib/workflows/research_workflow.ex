defmodule MultiAgentDemo.Workflows.ResearchWorkflow do
  def setup do
    # Create the workflow graph
    {:ok, graph} = GeckoOne.create_graph("research_workflow")

    # Add nodes (agents)
    :ok = GeckoOne.add_node(graph, :researcher, MultiAgentDemo.Agents.ResearchAgent)
    :ok = GeckoOne.add_node(graph, :analyzer, MultiAgentDemo.Agents.LLMAgent,
      config: [model: "gpt-4"])
    :ok = GeckoOne.add_node(graph, :summarizer, MultiAgentDemo.Agents.LLMAgent,
      config: [model: "gpt-3.5-turbo"])

    # Add edges with conditions
    :ok = GeckoOne.add_edge(graph, :researcher, :analyzer, fn message ->
      # Only proceed if research was successful
      Map.has_key?(message.content, :findings)
    end)

    :ok = GeckoOne.add_edge(graph, :analyzer, :summarizer, fn message ->
      # Only summarize if analysis is substantial
      String.length(message.content.text) > 100
    end)

    {:ok, graph}
  end

  def execute(topic) do
    with {:ok, graph} <- setup(),
         initial_input = %{topic: topic},
         {:ok, executor} <- GeckoOne.execute_workflow(
           "research_#{topic}",
           graph,
           :researcher,
           initial_input
         ) do
      # Monitor the workflow execution
      ref = Process.monitor(executor)
      receive do
        {:DOWN, ^ref, :process, _pid, :normal} ->
          {:ok, :completed}
        {:DOWN, ^ref, :process, _pid, reason} ->
          {:error, reason}
      end
    end
  end
end
