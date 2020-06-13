defmodule NsukiBusinessServiceWeb.AuthController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Accounts
  plug Ueberauth

  require Logger
  action_fallback NsukiBusinessServiceWeb.FallbackController

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    credential_params = %{
                           "token" => auth.credentials.token,
                           "email" => auth.info.email,
                           "provider" => Atom.to_string(auth.provider),
                         }
    user_params = %{
                      "first_name" => auth.info.first_name,
                      "last_name" => auth.info.last_name,
                      "verified" => true,
                      "credential" => credential_params
                   }

    signin(conn, user_params)
  end

  defp signin(conn, params) do
    case insert_or_update_user(params) do
      {:ok, credential_or_user} ->
        conn
        |> render("callback.json", credential_or_user: credential_or_user)
    end
  end

  defp insert_or_update_user(params) do
    %{"credential" => %{"email" => email}} = params
    case Accounts.get_credential_by_email(email) do
      nil ->
        params
        |> Accounts.create_user()
      credential ->
        {:ok, credential}
    end
  end
end
