defmodule Hangman.Dictionary.TopSup do
  use Application

  alias __MODULE__
  alias Hangman.Dictionary.Words

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    [
      # Child spec relying on use Agent...
      {Words, :ok}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end
end
