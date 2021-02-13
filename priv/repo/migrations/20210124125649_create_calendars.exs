defmodule NsukiBusinessService.Repo.Migrations.CreateCalendars do
  use Ecto.Migration

  def change do
    create table(:calendars) do
      add :summary, :string
      add :google_id, :string
      add :time_zone, :string
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

    create index(:calendars, [:business_id])
  end
end
