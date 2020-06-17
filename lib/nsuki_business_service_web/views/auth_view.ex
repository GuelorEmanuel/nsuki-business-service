defmodule NsukiBusinessServiceWeb.AuthView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.AuthView
  alias NsukiBusinessService.Accounts.{User, Credential}

  def render("callback.json", %{credential_or_user: credential_or_user, nbs_token: nbs_token}) do
    %{data: render_one(%{credential_or_user: credential_or_user, nbs_token: nbs_token}, AuthView, "auth.json")}
  end

  def render("auth.json", %{auth: %{credential_or_user: credential_or_user, nbs_token: nbs_token}}) do
    handle_credential_or_user(credential_or_user, nbs_token)
  end

  defp handle_credential_or_user(%User{first_name: first_name, last_name: last_name, credential: credential}, nbs_token) do
    %{
      first_name: first_name,
      last_name: last_name,
      email: credential.email,
      token: nbs_token
     }
  end
  defp handle_credential_or_user(%Credential{email: email, user: user}, nbs_token) do
    %{
      first_name: user.first_name,
      last_name: user.last_name,
      email: email,
      token: nbs_token
     }
  end
end

