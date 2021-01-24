defmodule NsukiBusinessService.Businesses.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calendars" do
    field :google_id, :string
    field :summary, :string
    field :time_zone, :string
    field :business_id, :id

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [:summary, :google_id, :time_zone])
    |> validate_required([:summary, :google_id, :time_zone])
  end
end
