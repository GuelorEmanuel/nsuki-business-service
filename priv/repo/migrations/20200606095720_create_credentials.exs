defmodule NsukiBusinessService.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :string
      add :provider, :string
      add :access_token, :string
      add :expires_at, :utc_datetime
      add :refresh_token, :string
      add :email_verified, :boolean
      add :token_type, :string
      add :password_hash, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:credentials, [:email])
    create index(:credentials, [:user_id])
  end
end
