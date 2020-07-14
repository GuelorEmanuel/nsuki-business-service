defmodule NsukiBusinessService.Services.Deposit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "deposits" do
    field :type, :string

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
