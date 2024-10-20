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
  Returns a random word from the dictionary.

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
  Returns the number of words in the dictionary.

  ## Examples

      iex> alias Hangman.Dictionary
      iex> Dictionary.word_count
      57713
  """
  @spec word_count :: pos_integer
  def word_count, do: Agent.get(WordsAgent, &length/1)

  @doc """
  Returns the shortest words in the dictionary (shorter than `ceil`).

  In iex, you may want to run:

  `IEx.configure(inspect: [limit: :infinity])`

  ## Examples

      iex> alias Hangman.Dictionary
      iex> Dictionary.shortest_words() |> Enum.take(49) |> Enum.take(-10)
      ["act", "add", "ado", "ads", "adz", "aft", "age", "ago", "aid", "ail"]

      iex> alias Hangman.Dictionary
      iex> Dictionary.shortest_words(2)
      ["a", "i"]
  """
  @spec shortest_words(pos_integer) :: [word]
  def shortest_words(ceil \\ 5) do
    Agent.get(WordsAgent, fn words ->
      words
      |> Stream.filter(&(byte_size(&1) < ceil))
      |> Enum.sort_by(&{byte_size(&1), &1})
    end)
  end

  @doc """
  Returns the longest words in the dictionary (longer than `floor`).
  Note that word lengths will be enclosed in parentheses after each word.

  In iex, you may want to run:

  `IEx.configure(inspect: [limit: :infinity])`

  ## Examples

      iex> alias Hangman.Dictionary
      iex> Dictionary.longest_words() |> Enum.take(9)
      [
        "telecommunications (18)",
        "characterization (16)",
        "responsibilities (16)",
        "sublimedirectory (16)",
        "characteristics (15)",
        "confidentiality (15)",
        "congratulations (15)",
        "instrumentation (15)",
        "internationally (15)"
      ]

      iex> alias Hangman.Dictionary
      iex> Dictionary.longest_words(14)
      [
        "telecommunications (18)",
        "characterization (16)",
        "responsibilities (16)",
        "sublimedirectory (16)",
        "characteristics (15)",
        "confidentiality (15)",
        "congratulations (15)",
        "instrumentation (15)",
        "internationally (15)",
        "pharmaceuticals (15)",
        "recommendations (15)",
        "representations (15)",
        "representatives (15)",
        "troubleshooting (15)"
      ]
  """
  @spec longest_words(non_neg_integer) :: [String.t()]
  def longest_words(floor \\ 13) do
    Agent.get(WordsAgent, fn words ->
      words
      |> Stream.filter(&(byte_size(&1) > floor))
      |> Stream.map(&"#{&1} (#{byte_size(&1)})")
      |> Enum.sort_by(&{-byte_size(&1), &1})
    end)
  end

  @doc """
  Returns all the words in the dictionary of length `word_length`.

  In iex, you may want to run:

  `IEx.configure(inspect: [limit: :infinity])`

  ## Examples

      iex> alias Hangman.Dictionary
      iex> Dictionary.words_of_length(16)
      ["characterization", "responsibilities", "sublimedirectory"]

      iex> alias Hangman.Dictionary
      iex> Dictionary.words_of_length(3) |> Enum.take(10)
      ["ace", "act", "add", "ado", "ads", "adz", "aft", "age", "ago", "aid"]
  """
  @spec words_of_length(pos_integer) :: [word]
  def words_of_length(word_length) do
    Agent.get(WordsAgent, fn words ->
      words
      |> Stream.filter(&(byte_size(&1) == word_length))
      |> Enum.sort()
    end)
  end

  @doc """
  Returns all the repeated words in the dictionary.
  Note that repetition counts will be enclosed in parentheses after each word.

  ## Examples

      iex> alias Hangman.Dictionary
      iex> Dictionary.repeated_words()
      ["echo (3)", "hello (2)"]
  """
  @spec repeated_words :: [String.t()]
  def repeated_words do
    Agent.get(WordsAgent, fn words ->
      words
      |> Enum.frequencies()
      |> Stream.filter(fn {_word, count} -> count > 1 end)
      |> Enum.sort_by(fn {word, count} -> {-count, word} end)
      |> Enum.map(fn {word, count} -> "#{word} (#{count})" end)
    end)
  end

  @doc """
  Returns all the words in the dictionary starting with `prefix`.

  ## Examples

      iex> alias Hangman.Dictionary
      iex> Dictionary.words_starting_with("monster")
      ["monster", "monsters"]

      iex> alias Hangman.Dictionary
      iex> Dictionary.words_starting_with("cock") |> Enum.take(3)
      ["cock", "cockade", "cockaded"]
  """
  @spec words_starting_with(String.t()) :: [word]
  def words_starting_with(prefix) do
    Agent.get(WordsAgent, fn words ->
      words
      |> Stream.filter(&String.starts_with?(&1, prefix))
      |> Enum.sort()
    end)
  end

  @doc """
  Refreshes the dictionary.
  """
  @spec refresh :: :ok
  defdelegate refresh, to: WordsAgent
end
