defmodule NsukiBusinessServiceWeb.CalendarController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.Accounts.User
  alias GoogleApi.Calendar.V3.Connection

  require Logger
  action_fallback NsukiBusinessServiceWeb.FallbackController

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    connection = create_connection(user)
    render(conn, "show.json", user: user)
  end

  defp create_connection(%User{id: id}) do
    user =
      id
      |> current_user_from_cache_or_repo()

    Logger.warn("user: #{inspect(user)}")
  end

  defp current_user_from_cache_or_repo(user_id) do
    ConCache.get_or_store(:current_user_cache, user_id, fn ->
      Accounts.get_user!(user_id)
    end)
  end
end
