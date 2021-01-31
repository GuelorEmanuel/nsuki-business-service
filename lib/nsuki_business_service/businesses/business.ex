defmodule NsukiBusinessService.Businesses.Business do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Accounts.User
  alias NsukiBusinessService.Businesses.{Calendar, Address}
  alias NsukiBusinessService.Services.Service

  schema "businesses" do
    field :phone_number, :string
    field :title, :string
    belongs_to :user, User
    has_one :calendar, Calendar
    has_many :address, Address
    has_many :service, Service

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:title, :phone_number])
    |> validate_required([:title, :phone_number])
  end
end
