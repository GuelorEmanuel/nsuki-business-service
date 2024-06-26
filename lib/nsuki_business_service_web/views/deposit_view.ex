defmodule NsukiBusinessServiceWeb.DepositView do
  use NsukiBusinessServiceWeb, :view
  alias NsukiBusinessServiceWeb.DepositView

  def render("index.json", %{deposits: deposits}) do
    %{data: render_many(deposits, DepositView, "deposit.json")}
  end

  def render("show.json", %{deposit: deposit}) do
    %{data: render_one(deposit, DepositView, "deposit.json")}
  end

  def render("deposit.json", %{deposit: deposit}) do
    %{id: deposit.id,
      type: deposit.type}
  end
end
