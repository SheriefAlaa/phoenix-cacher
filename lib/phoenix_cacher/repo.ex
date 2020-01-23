defmodule PhoenixCacher.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_cacher,
    adapter: Ecto.Adapters.Postgres
end
