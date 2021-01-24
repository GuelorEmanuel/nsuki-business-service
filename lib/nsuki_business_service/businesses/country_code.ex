defmodule NsukiBusinessService.Businesses.CountryCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "country_codes" do
    field :code, :integer

    timestamps()
  end

  @doc false
  def changeset(country_code, attrs) do
    country_code
    |> cast(attrs, [:code])
    |> validate_required([:code])
  end
end
