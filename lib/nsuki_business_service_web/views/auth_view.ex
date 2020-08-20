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
  def render("user.json", %{user: %{expires: expires, nbs_token: nbs_token, user: user}}) do
    handle_auth(user, nbs_token, expires)
  end
  defp handle_auth(%User{id: id, first_name: first_name, last_name: last_name,
                         verified: verified, image: image, credential: credential}, nbs_token, expires) do
    %{
      expires: expires,
      token: nbs_token,
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
