defmodule NsukiBusinessService.GoogleCalendarService do
  @behaviour Behaviour.NsukiBusinessService.CalendarServiceBehaviour

  alias GoogleApi.Calendar.V3.Connection
  alias GoogleApi.Calendar.V3.Api.CalendarList
  alias NsukiBusinessService.GoogleAPISTokenHolder

  require Logger

  def get_google_calendar_list(user_id, google_auth) do
    temp_calendars =
      user_id
      |> create_google_calendar_connection(google_auth)
      |> get_user_google_calendars()

    items =
      temp_calendars.items
      |> Enum.filter(fn x -> x.accessRole == "owner" end)

    Map.put(temp_calendars, :items, items)
  end

  defp create_google_calendar_connection(user_id, google_auth) do
    case GoogleAPISTokenHolder.put_auth_token(user_id, google_auth) do
      :ok ->
        user_id
        |> GoogleAPISTokenHolder.token()
        |> Connection.new()
    end
  end

  defp get_user_google_calendars(connection) do
    case CalendarList.calendar_calendar_list_list(connection) do
      {:ok, %{items: _items} = calendars} ->
        calendars
    end
  end

  # @TODO create default calendar if user doesn't have any calendars
  defp create_default_google_calendar(_connection) do
    :ok
  end
end
