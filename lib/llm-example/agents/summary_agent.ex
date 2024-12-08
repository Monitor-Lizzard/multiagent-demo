defmodule MultiAgentDemo.Agents.LLM.SummaryAgent do
  alias Whisperer.Langchain.Client
  alias Whisperer.Message
  @behaviour Whisperer.Agent

  @impl true
  def characteristics do
    %{
      id: "summary_agent",
      name: "Summary Agent",
      description: "Specializes in analyzing technical queries",
      capabilities: ["software", "analysis", "summary"]
    }
  end

  @impl true
  def process_message(message, context, conversation_history) do
    # history_context = format_conversation_history(conversation_history)

    # prompt = """
    # Previous conversation:
    # #{history_context}

    # You are a technical expert. Please respond to the following query:
    # #{message}

    # This is context you might need.
    # #{context}
    # """

    # llm()
    # |> LLMChain.add_message(prompt)
    # |> LLMChain.run()
    {:ok, %Message{content: "This is a response from the summary agent"}}
  end

  # def llm do
  #   Langchain.ChatModels.ChatOpenAI.new!(%{
  #     model: "llama3-70b-8192",
  #     temperature: 0.7,
  #     request_timeout: 30_000,
  #     endpoint: groq_base_url(),
  #     api_key: groq_api_key(),
  #   })
  #   end

  # defp format_conversation_history([]), do: "No previous conversation"
  # defp format_conversation_history(history) do
  #   history
  #   |> Enum.map_join("\n", fn msg ->
  #     "#{msg.role}: #{msg.content}"
  #   end)
  # end

  # defp get_api_key do
  #   System.get_env("OPENAI_API_KEY") ||
  #     raise "Environment variable OPENAI_API_KEY is not set"
  # end

  # defp groq_base_url, do: Application.get_env(:groq, :base_url)
  # defp groq_api_key, do: Application.get_env(:groq, :api_key)
end
