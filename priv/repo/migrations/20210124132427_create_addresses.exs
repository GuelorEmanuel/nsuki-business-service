defmodule NsukiBusinessService.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :street_no, :string
      add :apt_no, :string
      add :province_state, :string
      add :postal_code, :string
      add :business_id, references(:businesses, on_delete: :nothing)
      add :country_id, references(:countries, on_delete: :nothing)

      timestamps()
    end

    create index(:addresses, [:business_id])
    create index(:addresses, [:country_id])
  end
end
