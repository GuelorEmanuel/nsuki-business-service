defmodule NsukiBusinessServiceWeb.UserController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.Accounts.User

  require Logger

  action_fallback NsukiBusinessServiceWeb.FallbackController

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => _id, "user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
