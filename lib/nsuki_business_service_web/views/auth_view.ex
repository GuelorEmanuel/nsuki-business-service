defmodule NsukiBusinessServiceWeb.AuthView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.AuthView
  alias NsukiBusinessService.Accounts.{User, Credential}

  def render("callback.json", %{credential_or_user: credential_or_user}) do
    %{data: render_one(credential_or_user, AuthView, "auth.json")}
  end

  def render("auth.json", %{auth: auth}) do
    handle_credential_or_user(auth)
  end

  defp handle_credential_or_user(%User{first_name: first_name, last_name: last_name, credential: credential}) do
    %{first_name: first_name,
      last_name: last_name,
      email: credential.email
     }
  end
  defp handle_credential_or_user(%Credential{email: email, token: token, user: user}) do
    %{first_name: user.first_name,
      last_name: user.last_name,
      email: email,
      token: token
     }
  end
end

