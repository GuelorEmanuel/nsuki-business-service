defmodule Behaviour.NsukiBusinessService.CalendarServiceBehaviour do
  @callback get_google_calendar_list(integer(), %{expires_in: integer(), refresh_token: String.t, access_token: String.t}) :: any | {:error, any}
end
