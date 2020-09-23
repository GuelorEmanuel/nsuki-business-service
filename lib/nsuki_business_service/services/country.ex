defmodule NsukiBusinessService.Services.Country do
  use Ecto.Schema
  import Ecto.Changeset

  alias NsukiBusinessService.Services.CountryCode

  schema "countries" do
    field :name, :string
    has_one :country_code, CountryCode

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
