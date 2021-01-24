defmodule NsukiBusinessService.Businesses.Business do
  use Ecto.Schema
  import Ecto.Changeset

  schema "businesses" do
    field :phone_number, :string
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:title, :phone_number])
    |> validate_required([:title, :phone_number])
  end
end
