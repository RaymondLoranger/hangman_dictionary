defmodule Hangman.Dictionary.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hangman_dictionary,
      version: "0.1.22",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Hangman Dictionary",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/hangman_dictionary"
  end

  defp description do
    """
    Dictionary for the Hangman Game. Returns a random word in lowercase.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "assets/words.txt"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Hangman.Dictionary.TopSup, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
