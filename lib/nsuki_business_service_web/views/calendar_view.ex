require Protocol
Protocol.derive(Jason.Encoder, GoogleApi.Calendar.V3.Model.CalendarListEntry)
Protocol.derive(Jason.Encoder, GoogleApi.Calendar.V3.Model.ConferenceProperties)
Protocol.derive(Jason.Encoder, GoogleApi.Calendar.V3.Model.EventReminder)
Protocol.derive(Jason.Encoder, GoogleApi.Calendar.V3.Model.CalendarListEntryNotificationSettings)
Protocol.derive(Jason.Encoder, GoogleApi.Calendar.V3.Model.CalendarNotification)

defmodule NsukiBusinessServiceWeb.CalendarView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.CalendarView

  def render("index.json", %{calendar_list: calendar_list}) do
    %{data: render_one(calendar_list, CalendarView, "calendar_list.json")}
  end

  def render("calendar_list.json", %{calendar: %{items: items} = calendar_list}) do
    %{
      kind: calendar_list.kind,
      etag: calendar_list.etag,
      nextPageToken: calendar_list.nextPageToken,
      nextSyncToken: calendar_list.nextSyncToken,
      items: items
    }
  end
end
