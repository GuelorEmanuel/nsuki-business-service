defmodule NsukiBusinessService.Services.Price do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Services.{Service, Deposit}

  schema "prices" do
    field :base_price, :decimal
    field :deposit_price, :decimal
    field :travelling_fee, :decimal
    belongs_to :service, Service
    belongs_to :deposit, Deposit

    timestamps()
  end

  @doc false
  def changeset(price, attrs) do
    price
    |> cast(attrs, [:travelling_fee, :base_price, :deposit_price])
    |> validate_required([:travelling_fee, :base_price, :deposit_price])
  end
end
