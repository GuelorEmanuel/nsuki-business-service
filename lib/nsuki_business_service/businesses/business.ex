defmodule NsukiBusinessService.Businesses.Business do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  schema "businesses" do
    field :phone_number, :string
    field :title, :string
    field :country_code_id, :id

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:title, :phone_number])
    |> validate_required([:title, :phone_number])
  end
end
