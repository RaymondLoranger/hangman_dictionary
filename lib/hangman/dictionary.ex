# ┌──────────────────────────────────────────────────────────────┐
# │ Based on the course "Elixir for Programmers" by Dave Thomas. │
# └──────────────────────────────────────────────────────────────┘
defmodule Hangman.Dictionary do
  use PersistConfig

  @course_ref Application.get_env(@app, :course_ref)

  @moduledoc """
  Dictionary for the _Hangman Game_. Returns a random word in lowercase.

  ##### #{@course_ref}
  """

  alias __MODULE__.Words

  @doc """
  Returns a random word in lowercase.

  ## Examples

      iex> alias Hangman.Dictionary
      iex> [
      ...>   Dictionary.random_word(),
      ...>   Dictionary.random_word(),
      ...>   Dictionary.random_word(),
      ...>   Dictionary.random_word()
      ...> ]
      ...> |> Enum.all?(& &1 =~ ~r/^[a-z]+$/)
      true
  """
  @spec random_word :: String.t()
  def random_word, do: Agent.get(Words, &Enum.random/1)
end
