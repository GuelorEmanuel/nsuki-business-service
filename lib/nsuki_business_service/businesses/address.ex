defmodule NsukiBusinessService.Businesses.Address do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Businesses.{Business, Country}

  schema "addresses" do
    field :apt_no, :string
    field :postal_code, :string
    field :province_state, :string
    field :street_no, :string
    belongs_to :business, Business
    belongs_to :country, Country

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:street_no, :apt_no, :province_state, :postal_code])
    |> validate_required([:street_no, :province_state, :postal_code])
  end
end
