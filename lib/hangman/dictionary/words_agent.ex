defmodule Hangman.Dictionary.WordsAgent do
  @moduledoc """
  Agent that loads a list of words from external files.
  """

  use Agent
  use PersistConfig

  alias __MODULE__

  @paths get_env(:wildcard_paths)

  @doc """
  Starts an agent that loads a list of words from external files.

  ## Examples

      iex> alias Hangman.Dictionary.WordsAgent
      iex> {:error, {:already_started, agent}} = WordsAgent.start_link(:ok)
      iex> is_pid(agent) and agent == Process.whereis(WordsAgent)
      true
  """
  @spec start_link(term) :: Agent.on_start()
  def start_link(:ok = _arg), do: Agent.start_link(&init/0, name: WordsAgent)

  ## Private functions

  # Returns a list of words from (all) external files. All words must contain
  # letters between a and z, that is, be in lowercase without accented letters.
  @spec init :: [String.t()]
  defp init do
    Enum.flat_map(@paths, &words/1)
  end

  # Returns a list of words from external file `path`.
  defp words(path) do
    for word <- File.stream!(path), do: String.trim(word)
  end
end
