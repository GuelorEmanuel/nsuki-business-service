defmodule NsukiBusinessService.Services.Service do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Accounts.ServiceLocation

  schema "services" do
    field :description, :string
    field :duration, :time
    field :name, :string
    field :prices_id, :id
    belongs_to :service_location, ServiceLocation

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:name, :duration, :description])
    |> validate_required([:name, :duration, :description])
  end
end
