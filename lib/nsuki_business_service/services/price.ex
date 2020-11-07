defmodule NsukiBusinessService.Services.Price do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Services.Deposit

  schema "prices" do
    field :base_price, :integer
    field :deposit_amount, :integer
    field :travelling_fee, :integer
    belongs_to :deposit, Deposit

    timestamps()
  end

  @doc false
  def changeset(price, attrs) do
    price
    |> cast(attrs, [:travelling_fee, :base_price, :deposit_amount])
    |> validate_required([:travelling_fee, :base_price, :deposit_amount])
  end
end
