defmodule NsukiBusinessService.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :duration, :time
      add :description, :string
      add :prices_id, references(:prices, on_delete: :nothing)
      add :service_locations_id, references(:servicelocations, on_delete: :nothing)

      timestamps()
    end

    create index(:services, [:prices_id])
    create index(:services, [:service_locations_id])
  end
end
