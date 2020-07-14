defmodule NsukiBusinessService.Repo.Migrations.CreateServicelocations do
  use Ecto.Migration

  def change do
    create table(:servicelocations) do
      add :location, :string

      timestamps()
    end

  end
end
