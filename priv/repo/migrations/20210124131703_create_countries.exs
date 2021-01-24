defmodule NsukiBusinessService.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string
      add :country_code_id, references(:country_codes, on_delete: :nothing)

      timestamps()
    end

    create index(:countries, [:country_code_id])
  end
end
