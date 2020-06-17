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

  test "redirects user to Google for authentication", %{conn: conn} do
    conn =
      conn
      |> get("/api/v1/auth/google?scope=email%20profile")

    assert redirected_to(conn, 302)
  end

  test "creates user from Google information", %{conn: conn} do
    conn = conn
    |> assign(:ueberauth_auth, @ueberauth_auth)
    |> get("/api/v1/auth/google/callback")

    credentials = Credential |> Repo.all
    assert Enum.count(credentials) == 1
  end
end
