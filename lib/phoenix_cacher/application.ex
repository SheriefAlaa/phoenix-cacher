defmodule PhoenixCacher.Application do
  use Application

  def start(_type, _args) do
    children = [
      PhoenixCacher.Repo,
      PhoenixCacherWeb.Endpoint,
      PhoenixCacher.Server,
      {Cachex, :reaction}
    ]

    opts = [strategy: :one_for_one, name: PhoenixCacher.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    PhoenixCacherWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
