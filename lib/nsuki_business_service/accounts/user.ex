defmodule NsukiBusinessService.Accounts.User do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Accounts.Credential

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :verified, :boolean, default: false
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :verified])
    |> validate_required([:first_name, :last_name, :verified])
  end
end
