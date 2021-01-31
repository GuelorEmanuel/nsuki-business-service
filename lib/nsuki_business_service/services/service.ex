defmodule NsukiBusinessService.Services.Service do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Businesses.Business
  alias NsukiBusinessService.Services.ServiceLocation
  alias NsukiBusinessService.Services.Price

  schema "services" do
    field :description, :string
    field :duration, :string
    field :name, :string
    belongs_to :business, Business
    belongs_to :service_location, ServiceLocation
    has_one :price, Price

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:name, :duration, :description])
    |> validate_required([:name, :duration])
  end
end
