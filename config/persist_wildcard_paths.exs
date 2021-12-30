import Config

config :hangman_dictionary,
  wildcard_paths: Path.wildcard("#{File.cwd!()}/assets/**/*words*.txt")
