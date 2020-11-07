defmodule NsukiBusinessService.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :duration, :time
      add :description, :string
      add :prices_id, references(:prices, on_delete: :delete_all)
      add :service_location_id, references(:servicelocations, on_delete: :delete_all)

      timestamps()
    end

    create index(:services, [:prices_id])
    create index(:services, [:service_location_id])
  end
end
