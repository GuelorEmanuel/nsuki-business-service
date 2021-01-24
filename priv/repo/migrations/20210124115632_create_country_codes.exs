defmodule NsukiBusinessService.Repo.Migrations.CreateCountryCode do
  use Ecto.Migration

  def change do
    create table(:country_codes) do
      add :code, :integer

      timestamps()
    end

  end
end
