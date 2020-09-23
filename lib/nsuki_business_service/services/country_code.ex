defmodule NsukiBusinessService.Services.CountryCode do
  use Ecto.Schema
  import Ecto.Changeset

  alias NsukiBusinessService.Services.Country

  schema "countrycodes" do
    field :code, :integer
    belongs_to :country, Country

    timestamps()
  end

  @doc false
  def changeset(country_code, attrs) do
    country_code
    |> cast(attrs, [:code])
    |> validate_required([:code])
    |> unique_constraint(:code)
  end
end
