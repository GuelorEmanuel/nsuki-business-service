defmodule GoogleAPISTokenHolder do
  use GenServer

  @endpoint "https://funny-server.foo/oauth2/token"

  # Client APIs
  def start_link(_arg) do
    GenServer.start(__MODULE__, %{}, name: __MODULE__)
  end

  def token do
    GenServer.call(__MODULE__, :token)
  end

  def put_auth_token(auth_token) do
    GenServer.call(__MODULE__, {:put_auth_token, auth_token})
  end
  # Server APIs
  def init(state) do
    # fetch token and save it as state in the GenServer process
    {:ok, refresh_token()}
  end

  def handle_call(:token, _from, state) do
    {token, new_state} = get_token(state)
    {:reply, token, new_state}
  end

  def handle_call({:put_auth_token, auth_token}, _from, state) do
    # Set token
    # {token, new_state} = get_token(state)
    # {:reply, token, new_state}
  end

  defp refresh_token() do
    # ... lines skipped for brevity ...

    %{status_code: 200, body: body} =
      resp = HTTPoison.post!(@endpoint, payload, headers, options)
    # Successfully fetched access token

    body = Jason.decode!(body, keys: :atoms)
    Map.put(body, :expires_in, :os.system_time(:seconds) + body.expires_in)
  end

  defp get_token(%{expires_in: expires_in, access_token: token} = state) do
    now = :os.system_time(:seconds)

    # I am greedy ^_^
    has_aged? = now + 1 > expires_in

    if has_aged? do
      # Refresh OAuth token as it has aged
      auth = refresh_token()
      {auth.access_token, auth}
    else
      # No need to refresh, send back the same token
      {token, state}
    end
  end

  # def start_link(user,passwd) do
  #   Agent.start_link(fn ->
  #     tok_time = get_token user, passwd
  #     {user,passwd,tok_time}
  #   end, name: __MODULE__)
  # end

  # # refresh the token if older that three seconds
  # @max_age 3000000

  # def token do
  #   Agent.get_and_update(__MODULE__, fn state={user,passwd,{token,retrieved}} ->
  #     Logger.info "[PID=#{inspect self}=TokenHolder] Retrieving token"
  #     now = :os.timestamp
  #     age = :timer.now_diff(now, retrieved)
  #     if(age < @max_age) do
  #       Logger.info "Token age is #{age} - we can still use it"
  #       # return old token and old state
  #       {token,state}
  #     else
  #       Logger.info "Token age is #{age} - we must get a new one"
  #       # retrieve new token, return it and return changed state
  #       tok_time = {token,_} = get_token user, passwd
  #       {token,{user,passwd,tok_time}}
  #     end
  #   end)
  # end

  # defp get_token(_user,_passwd) do
  #   token = :random.uniform 100
  #   {token,:os.timestamp}
  # end

end
