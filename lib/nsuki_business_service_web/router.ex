defmodule NsukiBusinessServiceWeb.Router do
  use NsukiBusinessServiceWeb, :router
  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admins_only do
    plug :basic_auth, username:  "#{Application.get_env(:nsuki_business_service, NsukiBusinessServiceWeb.Endpoint)[:username]}",
                      password:  "#{Application.get_env(:nsuki_business_service, NsukiBusinessServiceWeb.Endpoint)[:password]}"
  end

  scope "/" do
    pipe_through :admins_only  
    live_dashboard "/dashboard"
  end

  scope "/api", NsukiBusinessServiceWeb do
    pipe_through :api
  end
end
