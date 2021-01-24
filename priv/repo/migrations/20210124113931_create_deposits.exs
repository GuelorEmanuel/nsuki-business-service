defmodule NsukiBusinessService.Repo.Migrations.CreateDeposits do
  use Ecto.Migration

  def change do
    create table(:deposits) do
      add :type, :string

      timestamps()
    end

  end
end
