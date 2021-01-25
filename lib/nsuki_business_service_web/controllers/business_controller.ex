defmodule NsukiBusinessServiceWeb.BusinessController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Businesses
  alias NsukiBusinessService.Businesses.Business

  action_fallback NsukiBusinessServiceWeb.FallbackController

  def index(conn, _params) do
    businesses = Businesses.list_businesses()
    render(conn, "index.json", businesses: businesses)
  end

  def create(conn, %{"business" => business_params}) do
    with {:ok, %Business{} = business} <- Businesses.create_business(business_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.business_path(conn, :show, business))
      |> render("show.json", business: business)
    end
  end

  def show(conn, %{"id" => id}) do
    business = Businesses.get_business!(id)
    render(conn, "show.json", business: business)
  end

  def update(conn, %{"id" => id, "business" => business_params}) do
    business = Businesses.get_business!(id)

    with {:ok, %Business{} = business} <- Businesses.update_business(business, business_params) do
      render(conn, "show.json", business: business)
    end
  end

  def delete(conn, %{"id" => id}) do
    service = Businesses.get_business!(id)

    with {:ok, %Business{}} <- Businesses.delete_business(service) do
      send_resp(conn, :no_content, "")
    end
  end
end
