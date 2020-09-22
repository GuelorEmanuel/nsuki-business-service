defmodule NsukiBusinessServiceWeb.AuthController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.UserFromAuth
  alias NsukiBusinessService.Guardian
  plug Ueberauth

  require Logger
  action_fallback NsukiBusinessServiceWeb.FallbackController

  def callback(conn, _params) do
    {:ok, user} = UserFromAuth.find_or_create(conn)
    signin(conn, user)
  end

  def get_user_with_jwt(conn, %{"token" => token}) do
    with {:ok, jwt_tokens} <- get_jwt(token),
         {:ok, resource, _claims} <- Guardian.resource_from_token(jwt_tokens.access_jwt),
         user <- Accounts.get_user(resource.id) do
          user_temp =
            %{
              user: user,
              nbs_refresh_token: jwt_tokens.refresh_jwt,
              refresh_exp: jwt_tokens.refresh_exp,
              nbs_access_token: jwt_tokens.access_jwt,
              access_exp: jwt_tokens.access_exp
             }
         conn
         |> render("user.json", user: user_temp)
    else
      _ ->
        conn
        |> render("user.json", user: nil)
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> respond_to_sign_out()
  end

  defp respond_to_sign_out(conn) do
    Logger.warn("delete was called: #{inspect(conn)}")
  end

  defp get_jwt(token) do
    case ConCache.get(:current_user_cache, String.to_atom(token)) do
      nil ->
        {:error, "Token doesn't exist or has expired"}
      jwt_tokens ->
        {:ok, jwt_tokens}
    end
  end

  def refresh_current_token(conn, %{"refresh_token" => old_refresh_token}) do
    with {:ok, _old_stuff, {new_token, new_claims}} <- Guardian.refresh(old_refresh_token, ttl: {5, :weeks}) do
      new_refresh_token = %{refresh_jwt: new_token, refresh_exp: new_claims["exp"]}
      conn
      |> render("refresh_token.json", refresh_token: new_refresh_token)
    end
  end

  defp exchange_refresh_token_for_access_token(jwt_refresh_token) do
    {:ok, _old_stuff, {new_token, new_claims}} = Guardian.exchange(jwt_refresh_token, "refresh", "access", ttl: {1, :hour})
    {:ok, new_token, new_claims}
  end

  defp generate_refresh_token_and_exchange_for_access_token(credential_or_user) do
     with {:ok, refresh_jwt, refresh_claims} <- Guardian.encode_and_sign(credential_or_user, %{}, token_type: "refresh", ttl: {5, :weeks}),  # issue a long living refresh token
          {:ok, access_jwt, access_claims} <- exchange_refresh_token_for_access_token(refresh_jwt) do # exchange the refresh token for a access token
          {:ok, %{refresh_jwt: refresh_jwt,
                  access_jwt: access_jwt,
                  refresh_exp: refresh_claims["exp"],
                  access_exp: access_claims["exp"]
                }
          }
     else
      _-> {:error, "Something went wrong with token generation"}
     end
  end

  defp signin(conn, params) do
    #thirty_days_in_minute = 43_200
    with {:ok, credential_or_user} <- create_user_or_get_credential(params),
         {:ok, tokens} <- generate_refresh_token_and_exchange_for_access_token(credential_or_user) do
          one_minutes_in_seconds = :timer.seconds(60)
          random_string = random_string(64)

          ConCache.put(:current_user_cache,
                 String.to_atom(random_string),
                 %ConCache.Item{value: tokens, ttl: one_minutes_in_seconds})
          Logger.warn("tokens: #{inspect(tokens)}")
          conn
          |> redirect(external: "http://localhost:3000/auth/google/callback?access_token=#{random_string}") #@TODO We Need to find a better way to do this
          #|> render("callback.json", credential_or_user: credential_or_user, nbs_token: token)
          #|> put_resp_header("Authorization", token)
    end
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  defp create_user_or_get_credential(%{"credential" => %{"email" => email}} = params) do
    case Accounts.get_credential_by_email(email) do
      nil ->
        Logger.warn("**Created user: #{inspect(params)}")
        params
        |> Accounts.create_user()
      credential ->
        {:ok, credential}
    end
  end
end
