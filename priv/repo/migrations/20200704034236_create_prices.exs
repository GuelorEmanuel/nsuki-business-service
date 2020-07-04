defmodule NsukiBusinessService.Repo.Migrations.CreatePrices do
  use Ecto.Migration

  def change do
    create table(:prices) do
      add :travelling_fee, :integer
      add :base_price, :integer
      add :deposit, :integer
      add :deposit_id, references(:deposits, on_delete: :nothing)

      timestamps()
    end

    create index(:prices, [:deposit_id])
  end
end
