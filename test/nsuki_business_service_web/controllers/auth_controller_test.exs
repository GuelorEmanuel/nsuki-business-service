defmodule NsukiBusinessServiceWeb.AuthControllerTest do
  use NsukiBusinessServiceWeb.ConnCase

  alias NsukiBusinessService.Repo
  alias NsukiBusinessService.Accounts.Credential

  # Using ueberauth for mocking out the response we get back from Google.
  @ueberauth_auth %{
    credentials: %{token: "fdsnoafhnoofh08h38h"},
    info: %{email: "queenb@example.com", first_name: "Beyonce", last_name: "Knowles"},
    provider: :google
  }

  test "creates user from Google information", %{conn: conn} do
    conn = conn
    |> assign(:ueberauth_auth, @ueberauth_auth)
    |> get("/auth/google/callback")

    credentials = Credential |> Repo.all
    assert Enum.count(credentials) == 1
    assert get_flash(conn, :info) == nil
  end
end
