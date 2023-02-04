defmodule Hangman.Dictionary.TopSup do
  use Application

  alias __MODULE__
  alias Hangman.Dictionary.WordsAgent

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_start_type, :ok = _start_args) do
    [
      # Child spec relying on `use Agent`...
      {WordsAgent, :ok}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end
end
