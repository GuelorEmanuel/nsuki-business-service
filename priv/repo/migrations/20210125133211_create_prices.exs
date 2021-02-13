defmodule NsukiBusinessService.Repo.Migrations.CreatePrices do
  use Ecto.Migration

  def change do
    create table(:prices) do
      add :travelling_fee, :decimal
      add :base_price, :decimal
      add :deposit_price, :decimal
      add :deposit_id, references(:deposits, on_delete: :nothing)
      add :service_id, references(:services, on_delete: :nothing)

      timestamps()
    end

    create index(:prices, [:deposit_id])
    create index(:prices, [:service_id])
  end
end
