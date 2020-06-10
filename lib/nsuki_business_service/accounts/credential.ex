defmodule NsukiBusinessService.Accounts.Credential do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Accounts.User

  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :provider, :string
    field :token, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
    |> unique_constraint(:email)
  end
end
