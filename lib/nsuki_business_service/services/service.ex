defmodule NsukiBusinessService.Services.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :description, :string
    field :duration, :time
    field :name, :string
    field :prices_id, :id
    field :service_locations_id, :id

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:name, :duration, :description])
    |> validate_required([:name, :duration, :description])
  end
end
