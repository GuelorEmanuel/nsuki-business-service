defmodule NsukiBusinessService.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :title, :string
      add :phone_number, :string
      add :country_code_id, references(:countrycodes, on_delete: :nothing)

      timestamps()
    end

    create index(:businesses, [:country_code_id])
  end
end
