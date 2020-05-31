defmodule NsukiBusinessServiceWeb.Router do
  use NsukiBusinessServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NsukiBusinessServiceWeb do
    pipe_through :api
  end
end
