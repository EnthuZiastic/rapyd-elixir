use Mix.Config

config :rapyd,
  access_key: System.get_env("ACCESS_KEY"),
  secret_key: System.get_env("SECRET_KEY"),
  mode: "sandbox"
