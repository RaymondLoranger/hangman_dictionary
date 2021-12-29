defmodule Hangman.Dictionary.TopSup do
  use Application

  alias __MODULE__
  alias Hangman.Dictionary.WordsAgent

  @spec start(Application.start_type(), start_args :: term) :: {:ok, pid}
  def start(_start_type, :ok) do
    [
      # Child spec relying on `use Agent`...
      {WordsAgent, :ok}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end
end
