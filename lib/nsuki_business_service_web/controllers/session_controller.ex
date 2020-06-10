defmodule NsukiBusinessServiceWeb.SessionController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Accounts.Credential
  plug Ueberauth

  action_fallback NsukiBusinessServiceWeb.FallbackController

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "google"}
    changeset = Credential.changeset(%Credential{}, user_params)

    signin(conn, changeset)
  end
  
  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> put_session(:user_id, user.id)
    end
  end
  
  defp insert_or_update_user(changeset) do
    case Repo.get_by(Credential, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      credential ->
        {:ok, credential}
    end
  end
end
