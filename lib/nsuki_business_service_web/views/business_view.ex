defmodule NsukiBusinessServiceWeb.BusinessView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.BusinessView

  def render("index.json", %{businesses: businesses}) do
    %{data: render_many(businesses, BusinessView, "business.json")}
  end

  def render("show.json", %{business: business}) do
    %{data: render_one(business, BusinessView, "business.json")}
  end

  def render("business.json", %{business: business}) do
    %{id: business.id,
      title: business.title,
      phone_number: business.phone_number}
  end
end
