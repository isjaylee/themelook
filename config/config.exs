# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :themelook,
  ecto_repos: [Themelook.Repo]

# Configures the endpoint
config :themelook, Themelook.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aN0jswP5J7fLjR6oMeDNqFc8Vt8dtzNKaJ1YPvL03RSCOcHItqhepQUm+Vip2suW",
  render_errors: [view: Themelook.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Themelook.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Themelook.User,
  repo: Themelook.Repo,
  module: Themelook,
  logged_out_url: "/",
  email_from: {"Your Name", "yourname@example.com"},
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, Themelook.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
