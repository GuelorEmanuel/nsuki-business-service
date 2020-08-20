defmodule NsukiBusinessServiceWeb.AuthController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.Guardian
  plug Ueberauth

  require Logger
  action_fallback NsukiBusinessServiceWeb.FallbackController

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    Logger.warn("auth: #{inspect(auth.info.image)}")
    credential_params = %{
                           "token" => auth.credentials.token,
                           "email" => auth.info.email,
                           "provider" => Atom.to_string(auth.provider),
                         }
    user_params = %{
                      "first_name" => auth.info.first_name,
                      "last_name" => auth.info.last_name,
                      "verified" => false,
                      "credential" => credential_params,
                      "image" => auth.info.image
                   }

    signin(conn, user_params)
  end

  def get_user_with_jwt(conn, %{"token" => token}) do
    with {:ok, jwt_token} <- get_jwt(token),
         {:ok, resource, _claims} <- Guardian.resource_from_token(jwt_token),
         user <- Accounts.get_user(resource.id) do
          user_temp = %{user: user, nbs_token: jwt_token, expires: 2} #@Todo figure out how to do expiration duration
         conn
         |> render("user.json", user: user_temp)
    else
      _ ->
        conn
        |> render("user.json", user: nil)
    end
  end

  defp get_jwt(token) do
    case ConCache.get(:current_user_cache, String.to_atom(token)) do
      nil ->
        {:error, "Token doesn't exist or has expired"}
      jwt_token ->
        {:ok, jwt_token}
    end
  end

  defp signin(conn, params) do
    #thirty_days_in_minute = 43_200
    with {:ok, credential_or_user} <- create_user_or_get_credential(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(credential_or_user, auth_time: true) do
          one_minutes_in_seconds = :timer.seconds(60)
          random_string = random_string(64)

          ConCache.put(:current_user_cache,
                 String.to_atom(random_string),
                 %ConCache.Item{value: token, ttl: one_minutes_in_seconds})
          conn
          |> redirect(external: "http://localhost:3000/auth/google/callback?access_token=#{random_string}") #@TODO We Need to find a better way to do this
          #|> render("callback.json", credential_or_user: credential_or_user, nbs_token: token)
          #|> put_resp_header("Authorization", token)
    end
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  defp create_user_or_get_credential(params) do
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
