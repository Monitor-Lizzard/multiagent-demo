defmodule MultiAgent.LLM.Sequencer do
  alias Whisperer.Sequence

  @behaviour Whisperer.Sequencer

  @impl true
  def create_sequence(_content, _characteristics, _conversation_history) do
    {:ok,
     %Sequence{
       start_agent: "tech_agent",
       connections: %{"tech_agent" => ["analysis_agent"], "analysis_agent" => ["summary_agent"]}
     }}
  end
end
