defmodule NsukiBusinessServiceWeb.CalendarControllerTest do
  use NsukiBusinessServiceWeb.ConnCase
  import Hammox

  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.Guardian
  alias Behaviour.NsukiBusinessService.CalendarServiceBehaviour
  alias NsukiBusinessService.MockCalendarServiceBehaviour

  @create_user %{
    first_name: "some first_name",
    last_name: "some last_name",
    verified: true,
    image: "some image"
  }
  @create_credential %{
    email: "some_email@email.com",
    password: "some password",
    provider: "some provider",
    access_token: "some accces_token",
    email_verified: false,
    token_type: "some token_type",
    refresh_token: "some refresh_token",
    expires_at: 100679
  }

  setup %{conn: conn} do
    {:ok, user} = Accounts.create_user(@create_user)
    {:ok, credential} = Accounts.create_credential(@create_credential, user)
    {:ok, jwt, _claims} = Guardian.encode_and_sign(user)

    conn =
      Phoenix.ConnTest.build_conn()
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{jwt}")

    {:ok, conn: conn, user: user}
  end

  describe "index" do
    test "lists all google calendar", %{conn: conn} do
      expect(MockCalendarServiceBehaviour, :get_google_calendar_list, fn (user_id, google_auth) ->
        %GoogleApi.Calendar.V3.Model.CalendarList{
          etag: "\"p32calm5dtv4eo0g\"",
          items:
            [
              %GoogleApi.Calendar.V3.Model.CalendarListEntry{
                accessRole: "reader",
                backgroundColor: "#92e1c0",
                colorId: "13",
                conferenceProperties: %GoogleApi.Calendar.V3.Model.ConferenceProperties{
                  allowedConferenceSolutionTypes: ["hangoutsMeet"]
                },
                defaultReminders: [],
                deleted: nil,
                description: "Displays birthdays, anniversaries, and other event dates of people in Google Contacts.",
                etag: "\"1578024575143000\"",
                foregroundColor: "#000000",
                hidden: nil,
                id: "addressbook#contacts@group.v.calendar.google.com",
                kind: "calendar#calendarListEntry",
                location: nil,
                notificationSettings: nil,
                primary: nil,
                selected: true,
                summary: "Birthdays",
                summaryOverride: nil,
                timeZone: "America/Toronto"
              },
            ],
            kind: "calendar#calendarList",
            nextPageToken: nil,
            nextSyncToken: "CJiq2K3vyOwCEiFndWVsb3IuZW1hbnVlbEBhbHVtbmkuY2FybGV0b24uY2E="
        }
      end)

      conn = get(conn, Routes.calendar_path(conn, :index))
      calendar_list = json_response(conn, 200)["data"]["items"]
      assert length(calendar_list) == 1
    end
  end
end
