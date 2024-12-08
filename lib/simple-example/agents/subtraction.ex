defmodule MultiAgentDemo.Simple.Agents.Subtraction do
  @moduledoc false

  @behaviour Whisperer.Agent

  @agent_id "subtraction"

  @impl true
  def characteristics do
    %{
      id: @agent_id,
      name: "Subtraction Agent",
      description: "Specializes in subtraction",
      capabilities: ["math", "subtraction"]
    }
  end

  @impl true
  def process_message(%{content: content}, _context, _conversation_history) do
    with result <- solve_subtraction(content) do
      {:ok, %Whisperer.Message{content: result, agent_id: @agent_id, role: :assistant}}
    end
  end

  defp solve_subtraction(input) do
    %{res: result} =
      Enum.reduce(String.split(input, "", trim: true), %{res: [], found: false}, fn
        curr, %{found: true, res: [prev | history]} ->
          %{res: ["#{String.to_integer(prev) - String.to_integer(curr)}" | history], found: false}

        "-", acc ->
          %{acc | found: true}

        curr, %{res: history} ->
          %{res: [curr | history], found: false}
      end)

    result |> Enum.reverse() |> List.to_string()
  end
end
