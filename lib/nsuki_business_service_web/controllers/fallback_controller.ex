defmodule NsukiBusinessServiceWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use NsukiBusinessServiceWeb, :controller
  require Logger

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(NsukiBusinessServiceWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(NsukiBusinessServiceWeb.ErrorView)
    |> render(:"422")
  end

  def call(conn, {:error, :internal_server_error}) do
    conn
    |> put_status(:not_found)
    |> put_view(NsukiBusinessServiceWeb.ErrorView)
    |> render(:"500")
  end
end
