defmodule NsukiBusinessService.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :verified, :boolean, default: false, null: false
      add :image, :text, null: false

      timestamps()
    end

  end
end
