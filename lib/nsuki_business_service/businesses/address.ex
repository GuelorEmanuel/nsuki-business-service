defmodule NsukiBusinessService.Businesses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :apt_no, :string
    field :postal_code, :string
    field :province_state, :string
    field :street_no, :string
    field :business_id, :id
    field :country_id, :id

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:street_no, :apt_no, :province_state, :postal_code])
    |> validate_required([:street_no, :apt_no, :province_state, :postal_code])
  end
end
