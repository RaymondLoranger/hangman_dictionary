defmodule Hangman.Dictionary.WordsAgent do
  @moduledoc """
  An agent process that loads a list of words from configured external files.
  """

  use Agent
  use PersistConfig

  alias __MODULE__
  alias Hangman.Dictionary

  @wildcard get_env(:wildcard)
  @paths Path.wildcard(@wildcard)

  @doc """
  Spawns an agent process that loads a list of words from external files.

  ## Examples

      iex> alias Hangman.Dictionary.WordsAgent
      iex> {:error, {:already_started, agent}} = WordsAgent.start_link(:ok)
      iex> is_pid(agent) and agent == Process.whereis(WordsAgent)
      true
  """
  @spec start_link(term) :: Agent.on_start()
  def start_link(_arg = :ok), do: Agent.start_link(&words/0, name: WordsAgent)

  @doc """
  Refreshes the agent state from the configured external files.
  """
  @spec refresh :: :ok
  def refresh, do: Agent.update(WordsAgent, fn _state -> words() end)

  ## Private functions

  # Returns a list of words from (all) external files. All words must contain
  # letters from `a` to `z`, i.e. be in lowercase without accented characters.
  @spec words :: [Dictionary.word()]
  defp words do
    ["echo", "echo", "hello" | Stream.flat_map(@paths, &words/1) |> Enum.uniq()]
  end

  # Returns a list of words from external file `path`.
  @spec words(Path.t()) :: [Dictionary.word()]
  defp words(path) do
    for word <- File.stream!(path), do: String.trim(word)
  end
end
