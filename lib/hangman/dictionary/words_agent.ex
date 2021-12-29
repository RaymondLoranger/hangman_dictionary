defmodule Hangman.Dictionary.WordsAgent do
  @moduledoc """
  Agent that loads a list of words from an external file.
  """

  use Agent
  use PersistConfig

  alias __MODULE__

  @words_path get_env(:words_path)

  @doc """
  Starts an agent that loads a list of words from an external file.

  ## Examples

      iex> alias Hangman.Dictionary.WordsAgent
      iex> {:error, {:already_started, agent}} = WordsAgent.start_link(:ok)
      iex> is_pid(agent) and agent == Process.whereis(WordsAgent)
      true
  """
  @spec start_link(term) :: Agent.on_start()
  def start_link(:ok = _arg), do: Agent.start_link(&init/0, name: WordsAgent)

  ## Private functions

  # Returns a list of lowercase words read from an external file.
  @spec init :: [String.t()]
  defp init do
    for word <- File.stream!(@words_path) do
      String.trim(word) |> String.downcase()
    end
  end
end
