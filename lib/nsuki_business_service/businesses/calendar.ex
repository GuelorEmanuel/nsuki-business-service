defmodule NsukiBusinessService.Businesses.Calendar do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Businesses.Business

  schema "calendars" do
    field :google_id, :string
    field :summary, :string
    field :time_zone, :string
    belongs_to :business, Business

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [:summary, :google_id, :time_zone])
    |> validate_required([:summary, :google_id, :time_zone])
  end
end
