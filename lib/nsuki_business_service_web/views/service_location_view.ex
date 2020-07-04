defmodule NsukiBusinessServiceWeb.ServiceLocationView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.ServiceLocationView

  def render("index.json", %{servicelocations: servicelocations}) do
    %{data: render_many(servicelocations, ServiceLocationView, "service_location.json")}
  end

  def render("show.json", %{service_location: service_location}) do
    %{data: render_one(service_location, ServiceLocationView, "service_location.json")}
  end

  def render("service_location.json", %{service_location: service_location}) do
    %{id: service_location.id,
      location: service_location.location}
  end
end
