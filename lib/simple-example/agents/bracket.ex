defmodule MultiAgentDemo.Simple.Agents.Bracket do
  @moduledoc false

  alias Whisperer.Message

  @behaviour Whisperer.Agent

  @agent_id "bracket"

  @impl true
  def characteristics do
    %{
      id: "bracket",
      name: "Bracket Agent",
      description: "Specializes in solving bracketed expressions",
      capabilities: ["math", "bracket"]
    }
  end

  @impl true
  def process_message(%{content: content}, _context, _conversation_history) do
    %{history: result} =
      Enum.reduce(String.split(content, "", trim: true), %{history: [], positions: []}, fn
        "(", %{history: history, positions: positions} = acc ->
          %{history: history ++ ["("], positions: [Enum.count(history) | positions]}

        ")", %{history: history, positions: [latest | positions]} = acc ->
          section = Enum.slice(history, (latest + 1)..Enum.count(history))

          {:ok, %Message{content: content}} =
            MultiAgentDemo.solve_bodmas_simple(List.to_string(section))

          case latest - 1 < 0 do
            true ->
              %{history: [content], positions: positions}

            false ->
              %{history: [Enum.slice(history, 0..(latest - 1)) | content], positions: positions}
          end

        curr, %{history: history, positions: positions} = acc ->
          %{history: history ++ [curr], positions: positions}
      end)

    {:ok,
     %Whisperer.Message{content: List.to_string(result), agent_id: @agent_id, role: :assistant}}
  end
end
