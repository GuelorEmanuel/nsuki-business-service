defmodule NsukiBusinessService.UserFromAuth do
  @moduledoc """
  Retrieve the user information from an auth request
  """
  require Logger
  require Poison

  def find_or_create(%{assigns: %{ueberauth_auth: auth}}) do
    {:ok, basic_info(auth)}
  end

  # github does it this way
  defp avatar_from_auth(%{info: %{urls: %{avatar_url: image}}}), do: image
  # facebook does it this way
  defp avatar_from_auth(%{info: %{image: image}}), do: image

  # default case if nothing matches
  defp avatar_from_auth(auth) do
    Logger.warn("#{auth.provider} needs to find an avatar URL!")
    Logger.debug(Poison.encode!(auth))
    nil
  end

  defp basic_info(auth) do
    Logger.warn("auth: #{inspect(auth)}")
    user_from_auth(auth)
  end

  defp user_from_auth(auth) do
    %{
      "first_name" => first_name_from_auth(auth),
      "last_name" => last_name_from_auth(auth),
      "verified" => false,
      "credential" => credential_from_auth(auth),
      "image" => avatar_from_auth(auth)
    }
  end

  defp credential_from_auth(auth) do
    %{
      "access_token" => access_token_from_auth(auth),
      "expires_at" => expires_at_from_auth(auth),
      "refresh_token" => refresh_token_from_auth(auth),
      "email" => email_from_auth(auth),
      "email_verified" => email_verified_from_auth(auth),
      "provider" => Atom.to_string(auth.provider),
      "token_type" => token_type_from_auth(auth)
    }
  end

  defp email_from_auth(%{info: %{email: email}}), do: email

  defp access_token_from_auth(%{credentials: %{token: token}}), do: token

  defp expires_at_from_auth(%{credentials: %{expires_at: expires_at}}) do
    DateTime.from_unix!(0)
    |> DateTime.add(expires_at, :second)
  end

  defp refresh_token_from_auth(%{credentials: %{refresh_token: refresh_token}}), do: refresh_token

  defp email_verified_from_auth(%{extra: %{raw_info: %{user: %{"email_verified" => email_verified}}}}), do: email_verified

  defp token_type_from_auth(%{credentials: %{token_type: token_type}}), do: token_type

  defp first_name_from_auth(%{info: %{first_name: first_name}}), do: first_name

  defp last_name_from_auth(%{info: %{last_name: last_name}}), do: last_name
end
