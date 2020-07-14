defmodule NsukiBusinessService.Services.Price do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prices" do
    field :base_price, :integer
    field :deposit, :integer
    field :travelling_fee, :integer
    field :deposit_id, :id

    timestamps()
  end

  @doc false
  def changeset(price, attrs) do
    price
    |> cast(attrs, [:travelling_fee, :base_price, :deposit])
    |> validate_required([:travelling_fee, :base_price, :deposit])
  end
end
