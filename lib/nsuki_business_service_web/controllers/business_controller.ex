defmodule NsukiBusinessServiceWeb.BusinessController do
  use NsukiBusinessServiceWeb, :controller

  alias NsukiBusinessService.Businesses
  alias NsukiBusinessService.Businesses.Business

  action_fallback NsukiBusinessServiceWeb.FallbackController

  def index(conn, _params) do
    businesses = Businesses.list_businesses()
    render(conn, "index.json", businesses: businesses)
  end

  def guardian_get_current_resource(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil -> {:error, :no_resource_found}
      user -> {:ok, user}
    end
  end
  def on_boarding(conn, %{"data" => on_boarding_params}) do
    with {:ok, on_boarding_params_temp} <- generate_on_boarding_map(on_boarding_params),
         {:ok, user} <- guardian_get_current_resource(conn),
         false <- does_bussines_exist?(user),
        {:ok, business} <- Businesses.create_business_on_boarding(on_boarding_params_temp, user)
    do
      render(conn, "show.json", business: business)
    else
      _ -> {:error, :internal_server_error}

    end
  end

  defp does_bussines_exist?(user) do
    case Businesses.get_business_by_user(user) do
      nil -> false
      _ -> true
    end
  end
  defp generate_on_boarding_map(on_boarding_params) do
    case Jason.decode!(on_boarding_params) do
      # do something
      {:error, err} -> {:error, err}

      on_boarding_map ->
        %{"calendar" => calendar,"businessName" => business_name,
          "streetAddress" => street_address, "provinceStates" => province_states,
          "ZIPcodePostalCode" => zip_code_postal_code,"phone_number" => phone_number,
          "country" => country, "appointmentName" => appointment_name,
          "durationInMinute" => duration_in_minute, "price" => price,
          "serviceLocation" => service_location, "depositType" => deposit_type
        } = on_boarding_map

        dp_amount =  if on_boarding_map["amount"] == nil, do: 0, else: on_boarding_map["amount"]
        apt_nums = if on_boarding_map["apartmentSuite"] == nil, do: "", else: on_boarding_map["apartmentSuite"]
        descript = if on_boarding_map["description"] == nil, do: "", else: on_boarding_map["description"]

        calendar = %{google_id: calendar["id"], summary: calendar["summary"], time_zone: calendar["timeZone"]}
        business = %{phone_number: phone_number, title: business_name}
        country = %{name: country}
        address = %{apt_no: apt_nums, postal_code: zip_code_postal_code, province_state: province_states, street_no: street_address}
        price = %{base_price: price, deposit_price: dp_amount, travelling_fee: 0}
        service = %{description: descript, duration: duration_in_minute, name: appointment_name}

        on_boarding_map_temp = %{
                                  "calendar" => calendar, "business" => business,
                                  "country" => country, "address" => address, "price" => price,
                                  "service" => service, "service_location" => service_location,
                                  "deposit_type" => deposit_type
                                }

        {:ok, on_boarding_map_temp}
    end
  end

  def create(conn, %{"business" => business_params}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %Business{} = business} <- Businesses.create_business(business_params, user) do
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
