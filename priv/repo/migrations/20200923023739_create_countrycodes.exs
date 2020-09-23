defmodule NsukiBusinessService.Repo.Migrations.CreateCountrycodes do
  use Ecto.Migration

  def change do
    create table(:countrycodes) do
      add :code, :integer
      add :country_id, references(:countries, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:countrycodes, [:code])
    create index(:countrycodes, [:country_id])
  end
end
