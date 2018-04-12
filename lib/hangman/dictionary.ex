# ┌──────────────────────────────────────────────────────────────┐
# │ Based on the course "Elixir for Programmers" by Dave Thomas. │
# └──────────────────────────────────────────────────────────────┘
defmodule Hangman.Dictionary do
  use PersistConfig

  @course_ref Application.get_env(@app, :course_ref)

  @moduledoc """
  Dictionary for the Hangman game. Returns a random word in lowercase.

  ##### #{@course_ref}
  """

  alias __MODULE__.Words

  @doc """
  Returns a random word in lowercase.

  ## Examples

      iex> alias Hangman.Dictionary
      iex> Dictionary.random_word() =~ ~r/^[a-z]+$/
      true
  """
  defdelegate random_word(), to: Words
end
