defmodule MultiAgentDemo do
  @moduledoc """
  Documentation for `MultiAgentDemo`.
  """
  alias MultiAgent.Sequencer

  def sample_llm(content) do
    {:ok, _} = Supervisor.start_orchestrator("random-test-orchestrator", Sequencer, %{})
    Whisperer.Orchestrator.add_agent("random-test-orchestrator", MultiAgentDemo.Agents.TechAgent)

    Whisperer.Orchestrator.add_agent(
      "random-test-orchestrator",
      MultiAgentDemo.Agents.AnalysisAgent
    )

    Whisperer.Orchestrator.add_agent(
      "random-test-orchestrator",
      MultiAgentDemo.Agents.SummaryAgent
    )

    Orchestrator.process_user_input("random-test-orchestrator", content)
  end

  def solve_bodmas_simple(content) do
    session_id = UUID.uuid4()
    {:ok, _} = Whisperer.start_session(session_id, MultiAgentDemo.Simple.Sequencer, %{})
    Whisperer.add_agent(session_id, MultiAgentDemo.Simple.Agents.Bracket)
    Whisperer.add_agent(session_id, MultiAgentDemo.Simple.Agents.Division)
    Whisperer.add_agent(session_id, MultiAgentDemo.Simple.Agents.Multiplication)
    Whisperer.add_agent(session_id, MultiAgentDemo.Simple.Agents.Addition)
    Whisperer.add_agent(session_id, MultiAgentDemo.Simple.Agents.Subtraction)

    Whisperer.process_user_input(session_id, content)
  end
end
