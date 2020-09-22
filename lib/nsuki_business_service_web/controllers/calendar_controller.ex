defmodule NsukiBusinessServiceWeb.CalendarController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.Accounts.User
  alias NsukiBusinessService.Accounts.Credential
  alias GoogleApi.Calendar.V3.Connection
  alias GoogleApi.Calendar.V3.Api.CalendarList

  require Logger
  action_fallback NsukiBusinessServiceWeb.FallbackController

  def index(conn, _params) do
    Logger.warn("Index..")
    user = Guardian.Plug.current_resource(conn)
    google_token = user.credential.access_token
    connection = create_connection(google_token)
    render(conn, "show.json", user: user)
  end

  defp create_connection(google_token) do
    Logger.warn("token: #{google_token}")
    connection =
      Connection.new(google_token)
      |> CalendarList.calendar_calendar_list_list()

    Logger.warn("connection: #{inspect(connection)}")
  end

  defp current_user_from_cache_or_repo(user_id) do
    ConCache.get_or_store(:current_user_calendar_cache, user_id, fn ->
      Accounts.get_user!(user_id)
    end)
  end
end
