defmodule NsukiBusinessServiceWeb.Router do
  use NsukiBusinessServiceWeb, :router
  require Ueberauth
  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  alias NsukiBusinessService.Guardian


  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: "*"
  end

  pipeline :admins_only do
    plug :basic_auth, username:  "#{Application.get_env(:nsuki_business_service, NsukiBusinessServiceWeb.Endpoint)[:username]}",
                      password:  "#{Application.get_env(:nsuki_business_service, NsukiBusinessServiceWeb.Endpoint)[:password]}"
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/" do
    pipe_through :admins_only
    live_dashboard "/dashboard"
  end

  scope "/api/v1", NsukiBusinessServiceWeb do
    pipe_through [:api, :jwt_authenticated]

    resources "/users", UserController, except: [:new, :edit, :index, :create]
    resources "/calendar", CalendarController, except: [:new, :edit, :create]
    resources "/services", ServiceController
    resources "/businesses", BusinessController
    post "/logout", AuthController, :delete
  end

  scope "/api/v1/auth", NsukiBusinessServiceWeb do
    pipe_through :api

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    get "/get_credential/:token", AuthController, :get_user_with_jwt
    post "/refresh_token", AuthController, :refresh_current_token
  end
end
