defmodule NsukiBusinessService.Businesses.CountryCode do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Businesses.Country

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
