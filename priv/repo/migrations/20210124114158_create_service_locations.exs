defmodule NsukiBusinessService.Repo.Migrations.CreateServiceLocations do
  use Ecto.Migration

  def change do
    create table(:service_locations) do
      add :location, :string

      timestamps()
    end

  end
end
