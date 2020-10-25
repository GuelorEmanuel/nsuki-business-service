defmodule NsukiBusinessService.GoogleAPISTokenHolder do
  use GenServer

  @endpoint "https://www.googleapis.com/oauth2/v4/token"

  # Client APIs
  def start_link(_arg) do
    GenServer.start(__MODULE__, %{}, name: __MODULE__)
  end

  def token(user_id) do
    GenServer.call(__MODULE__, {:token, user_id})
  end

  def put_auth_token(user_id, auth_token) do
    GenServer.cast(__MODULE__, {:put_auth_token, user_id, auth_token})
  end

  # Server APIs
  def init(state) do
    # fetch token and save it as state in the GenServer process
    {:ok, state}
  end

  def handle_call({:token, user_id}, _from, state) do
    {token, new_state} = get_token(user_id, state)
    {:reply, token, new_state}
  end

  def handle_cast({:put_auth_token, user_id, auth_token}, state) do
    # Set token
    case Map.has_key?(state, user_id) do
      true ->
        {:noreply, state}
      false ->
        {:noreply, Map.put(state, user_id, auth_token)}
    end
  end

  defp refresh_token(refresh_token) do
    # ... lines skipped for brevity ...
    # post!(url, body, headers \\ [], options \\ [])

    payload = "{\"client_id\": \"#{Application.get_env(:ueberauth, Ueberauth.Strategy.Google.OAuth)[:client_id]}\",\n
             \"client_secret\": \"#{Application.get_env(:ueberauth, Ueberauth.Strategy.Google.OAuth)[:client_secret]}\",\n
             \"refresh_token\": \"#{refresh_token}\",\n
             \"grant_type\": \"refresh_token\"}"


    %{status_code: 200, body: body} =
      resp = HTTPoison.post!(@endpoint, payload)
      # Successfully fetched access token

    body = Jason.decode!(body, keys: :atoms)
    Map.put(body, :expires_in, :os.system_time(:seconds) + body.expires_in)
  end

  defp get_token(user_id, state) do
    now = :os.system_time(:seconds)
    temp_state = Map.fetch!(state, user_id)
    %{expires_in: expires_in, refresh_token: refresh_token, access_token: access_token} = temp_state

    # I am greedy ^_^
    has_aged? = now + 1 > expires_in

    if has_aged? do
      # Refresh OAuth token as it has aged
      auth =
        refresh_token
        |> refresh_token()

      {auth.access_token, auth}
    else
      # No need to refresh, send back the same token
      {access_token, state}
    end
  end
end
