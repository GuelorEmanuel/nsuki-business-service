defmodule NsukiBusinessServiceWeb.AuthView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.AuthView
  alias NsukiBusinessService.Accounts.{User, Credential}

  require Logger

  def render("callback.json", %{credential_or_user: credential_or_user, nbs_token: nbs_token}) do
    %{data: render_one(%{credential_or_user: credential_or_user, nbs_token: nbs_token}, AuthView, "auth.json")}
  end

  def render("auth.json", %{auth: %{credential_or_user: credential_or_user, nbs_token: nbs_token}}) do
    handle_credential_or_user(credential_or_user, nbs_token)
  end

  def render("user.json", %{user: user}) when user == nil, do: user
  def render("user.json", %{user: %{nbs_refresh_token: nbs_refresh_token,
                            nbs_refresh_exp: nbs_refresh_exp, nbs_access_token: nbs_access_token,
                            nbs_access_exp: nbs_access_exp, user: user}}) do
    handle_auth(user, nbs_refresh_token, nbs_refresh_exp, nbs_access_token, nbs_access_exp)
  end

  def render("refresh_token.json", %{nbs_refresh_token: %{nbs_refresh_jwt: nbs_refresh_jwt, nbs_refresh_exp: nbs_refresh_exp}}), do: %{nbs_refresh_jwt: nbs_refresh_jwt, nbs_refresh_exp: nbs_refresh_exp}

  defp handle_auth(%User{id: id, first_name: first_name, last_name: last_name,
                         verified: verified, image: image, credential: credential},
                         nbs_refresh_token, nbs_refresh_exp, nbs_access_token, nbs_access_exp) do
    %{
      nbs_refresh_token: nbs_refresh_token,
      nbs_refresh_exp: nbs_refresh_exp,
      nbs_access_token: nbs_access_token,
      nbs_access_exp: nbs_access_exp,
      user: %{
        id: id,
        first_name: first_name,
        last_name: last_name,
        email: credential.email,
        verified: verified,
        image: image
      }
     }
  end

  defp handle_credential_or_user(%User{id: id, first_name: first_name, last_name: last_name,
                                       verified: verified, credential: credential, image: image}, nbs_token) do
    %{
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: credential.email,
      token: nbs_token,
      verified: verified,
      image: image
     }
  end
  defp handle_credential_or_user(%Credential{email: email, user: user}, nbs_token) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: email,
      token: nbs_token,
      verified: user.verified,
      image: user.image
     }
  end
end
