defmodule NsukiBusinessServiceWeb.CalendarController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.GoogleCalendarService

  @google_calendar_service Application.get_env(:nsuki_business_service, :google_calendar_service)

  action_fallback NsukiBusinessServiceWeb.FallbackController

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    google_auth = %{
      expires_in: user.credential.expires_at,
      refresh_token: user.credential.refresh_token,
      access_token: user.credential.access_token
    }
    calendar_list =
      user.id
      |> @google_calendar_service.get_google_calendar_list(google_auth)

    render(conn, "index.json", calendar_list: calendar_list)
  end

  defp current_user_from_cache_or_repo(user_id) do
    ConCache.get_or_store(:current_user_calendar_cache, user_id, fn ->
      Accounts.get_user!(user_id)
    end)
  end
end
