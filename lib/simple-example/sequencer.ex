defmodule MultiAgentDemo.Simple.Sequencer do
  @moduledoc false

  alias Whisperer.Sequence
  @behaviour Whisperer.Sequencer

  @impl true
  def create_sequence(_content, _characteristics, _conversation_history) do
    {:ok,
     %Sequence{
       start_agent: "bracket",
       connections: %{
         "bracket" => ["division"],
         "division" => ["multiplication"],
         "multiplication" => ["addition"],
         "addition" => ["subtraction"]
       }
     }}
  end
end
