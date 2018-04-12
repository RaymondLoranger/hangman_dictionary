defmodule Hangman.Dictionary.Words do
  # @moduledoc """
  # Starts a dictionary agent to return random words.
  # """
  @moduledoc false

  use Agent
  use PersistConfig

  alias __MODULE__

  @words_path Application.get_env(@app, :words_path)

  @doc """
  Starts an agent.

  ## Examples

      iex> alias Hangman.Dictionary.Words
      iex> {:error, {:already_started, agent}} = Words.start_link(:ok)
      iex> is_pid(agent) and agent == Process.whereis(Words)
      true
  """
  @spec start_link(term) :: Agent.on_start()
  def start_link(:ok), do: Agent.start_link(&init/0, name: Words)

  @doc """
  Returns a random word in lowercase.

  ## Examples

      iex> alias Hangman.Dictionary.Words
      iex> Words.random_word() =~ ~r/^[a-z]+$/
      true
  """
  @spec random_word() :: String.t()
  def random_word(), do: Agent.get(Words, &Enum.random/1)

  ## Private functions

  # @doc """
  # Returns a list of lowercase words read from an external file.

  # ## Examples

  #     iex> alias Hangman.Dictionary.Words
  #     iex> words = Words.init()
  #     iex> {length(words), is_list(words)}
  #     {8881, true}
  # """
  @spec init() :: [String.t()]
  defp init() do
    for word <- File.stream!(@words_path) do
      word |> String.trim() |> String.downcase()
    end
  end
end
