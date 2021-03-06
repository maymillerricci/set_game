# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :set_game,
  ecto_repos: [SetGame.Repo]

# Configures the endpoint
config :set_game, SetGame.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wnD9sbHT5xnPT5IiKZbaxMQpMPFmW6P5S5+uOToVJm6ERFLy0DROXcvVB4KKBvqW",
  render_errors: [view: SetGame.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SetGame.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
