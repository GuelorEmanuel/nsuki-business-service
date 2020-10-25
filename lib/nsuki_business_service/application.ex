defmodule NsukiBusinessService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      NsukiBusinessService.Repo,
      # Start the endpoint when the application starts
      NsukiBusinessServiceWeb.Endpoint,
      # Starts a worker by calling: NsukiBusinessService.Worker.start_link(arg)
      # {NsukiBusinessService.Worker, arg},
      # Start google_apis_token_holder
      NsukiBusinessService.GoogleAPISTokenHolder,
      {ConCache,
      [
        name: :current_user_cache,
        ttl_check_interval: 2_000,
        global_ttl: 2_000,
        touch_on_read: true
      ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NsukiBusinessService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NsukiBusinessServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
