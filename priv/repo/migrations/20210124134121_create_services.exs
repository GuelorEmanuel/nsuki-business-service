defmodule NsukiBusinessService.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :duration, :string
      add :description, :string
      add :service_location_id, references(:service_locations, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps()
    end

    create index(:services, [:service_location_id])
  end
end
