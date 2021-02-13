defmodule NsukiBusinessService.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :title, :string
      add :phone_number, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:businesses, [:user_id])
  end
end
