defmodule NsukiBusinessServiceWeb.Router do
  use NsukiBusinessServiceWeb, :router
  require Ueberauth
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
    resources "/users", UserController, except: [:new, :edit]
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/auth", NsukiBusinessServiceWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
end
