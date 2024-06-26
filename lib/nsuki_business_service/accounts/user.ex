defmodule NsukiBusinessService.Accounts.User do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  import Ecto.Changeset

  alias NsukiBusinessService.Accounts.Credential
  alias NsukiBusinessService.Businesses.Business

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :verified, :boolean, default: false
    field :image, :string, size: 200, default: ""
    has_one :credential, Credential
    has_one :business, Business

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :verified, :image])
    |> validate_required([:first_name, :last_name, :verified, :image])
  end
end
