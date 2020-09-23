defmodule NsukiBusinessService.Services.Deposit do
  use Ecto.Schema
  import Ecto.Changeset

  alias NsukiBusinessService.Services.Price

  schema "deposits" do
    field :type, :string
    has_many :price, Price

    timestamps()
  end

  @doc false
  def changeset(deposit, attrs) do
    deposit
    |> cast(attrs, [:type])
    |> validate_required([:type])
    |> unique_constraint(:type)
  end
end
