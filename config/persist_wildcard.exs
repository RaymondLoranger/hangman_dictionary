import Config

root_dir = File.cwd!()
config :hangman_dictionary, wildcard: "#{root_dir}/assets/**/*words*.txt"
