defmodule NsukiBusinessServiceWeb.PriceView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.PriceView

  def render("index.json", %{prices: prices}) do
    %{data: render_many(prices, PriceView, "price.json")}
  end

  def render("show.json", %{price: price}) do
    %{data: render_one(price, PriceView, "price.json")}
  end

  def render("price.json", %{price: price}) do
    %{id: price.id,
      travelling_fee: price.travelling_fee,
      base_price: price.base_price,
      deposit: price.deposit}
  end
end
