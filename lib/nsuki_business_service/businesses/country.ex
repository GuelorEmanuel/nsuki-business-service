defmodule NsukiBusinessService.Businesses.Country do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Businesses.{Address, CountryCode}

  schema "countries" do
    field :name, :string
    has_many :address, Address
    belongs_to :country_code, CountryCode

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
