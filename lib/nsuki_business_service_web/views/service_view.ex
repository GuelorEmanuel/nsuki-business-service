defmodule NsukiBusinessServiceWeb.ServiceView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.ServiceView

  def render("index.json", %{services: services}) do
    %{data: render_many(services, ServiceView, "service.json")}
  end

  def render("show.json", %{service: service}) do
    %{data: render_one(service, ServiceView, "service.json")}
  end

  def render("service.json", %{service: service}) do
    %{id: service.id,
      name: service.name,
      duration: service.duration,
      description: service.description}
  end
end
