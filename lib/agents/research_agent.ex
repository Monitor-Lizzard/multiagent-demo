defmodule MultiAgentDemo.Agents.ResearchAgent do
  @behaviour GeckoOne.Agents.AgentBehaviour

  @impl true
  def init(_config), do: {:ok, %{}}

  @impl true
  def execute(inputs, state, _config) do
    # Research processing logic
    result = research_topic(inputs.topic)
    {:ok, result, state}
  end

  @impl true
  def prepare_workflow(_inputs, state) do
    {:ok, %{ready: true}, state}
  end

  @impl true
  def validate_config(_config), do: :ok

  @impl true
  def capabilities() do
    MapSet.new([:research, :data_gathering])
  end

  defp research_topic(topic) do
    %{findings: "Research results for: #{topic}"}
  end
end
