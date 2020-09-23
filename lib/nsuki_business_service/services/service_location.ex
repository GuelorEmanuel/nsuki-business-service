defmodule NsukiBusinessService.Services.ServiceLocation do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Services.Service

  schema "servicelocations" do
    field :location, :string
    has_many :service, Service

    timestamps()
  end

  @doc false
  def changeset(service_location, attrs) do
    service_location
    |> cast(attrs, [:location])
    |> validate_required([:location])
    |> unique_constraint(:location)
  end
end
