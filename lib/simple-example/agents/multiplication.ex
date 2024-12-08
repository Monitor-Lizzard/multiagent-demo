defmodule MultiAgentDemo.Simple.Agents.Multiplication do
  @moduledoc false

  @agent_id "multiplication"

  @behaviour Whisperer.Agent

  @impl true
  def characteristics do
    %{
      id: @agent_id,
      name: "Multiplication Agent",
      description: "Specializes in multiplying numbers",
      capabilities: ["math", "multiplication"]
    }
  end

  @impl true
  def process_message(%_{content: content} = msg, _context, _conversation_history) do
    with result <- solve_multiplication(content) do
      {:ok, %Whisperer.Message{content: result, agent_id: @agent_id, role: :assistant}}
    end
  end

  defp solve_multiplication(input) do
    %{res: result} =
      Enum.reduce(String.split(input, "", trim: true), %{res: [], found: false}, fn
        curr, %{found: true, res: [prev | history]} ->
          %{res: ["#{String.to_integer(prev) * String.to_integer(curr)}" | history], found: false}

        "*", acc ->
          %{acc | found: true}

        curr, %{res: history} ->
          %{res: [curr | history], found: false}
      end)

    result |> Enum.reverse() |> List.to_string()
  end
end
