defmodule NsukiBusinessService.Services.ServiceLocation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "service_locations" do
    field :location, :string

    timestamps()
  end

  @doc false
  def changeset(service_location, attrs) do
    service_location
    |> cast(attrs, [:location])
    |> validate_required([:location])
  end
end
