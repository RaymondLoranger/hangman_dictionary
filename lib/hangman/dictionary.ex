# ┌──────────────────────────────────────────────────────────────┐
# │ Based on the course "Elixir for Programmers" by Dave Thomas. │
# └──────────────────────────────────────────────────────────────┘
defmodule Hangman.Dictionary do
  @moduledoc """
  Dictionary for the _Hangman Game_. Returns a random word.

  ##### Based on the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias __MODULE__.WordsAgent

  @typedoc "A word with letters from a to z"
  @type word :: String.t()

  @doc """
  Returns a random word from the dictionary agent.

  ## Examples

      iex> alias Hangman.Dictionary
      iex> for _ <- 0..99, uniq: true do
      iex>   Dictionary.random_word() =~ ~r/^[a-z]+$/
      iex> end
      [true]

      iex> alias Hangman.Dictionary.WordsAgent
      iex> words = Agent.get(WordsAgent, & &1)
      iex> Enum.all?(words, & &1 =~ ~r/^[a-z]+$/)
      true
  """
  @spec random_word :: word
  def random_word, do: Agent.get(WordsAgent, &Enum.random/1)

  @doc """
  Returns the number of words in the dictionary agent.

  ## Examples

      iex> alias Hangman.Dictionary
      iex> Dictionary.word_count
      9133
  """
  @spec word_count :: pos_integer
  def word_count, do: Agent.get(WordsAgent, &length/1)
end
