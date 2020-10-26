defmodule NsukiBusinessService.AccountsTest do
  use NsukiBusinessService.DataCase

  alias NsukiBusinessService.Accounts

  defp unload_relations(obj, to_remove \\ nil) do
    assocs =
      if to_remove == nil,
        do: obj.__struct__.__schema__(:associations),
      else: Enum.filter(obj.__struct__.__schema__(:associations), &(&1 in to_remove))

      Enum.reduce(assocs, obj, fn assoc, obj ->
        assoc_meta = obj.__struct__.__schema__(:association, assoc)

        Map.put(obj, assoc, %Ecto.Association.NotLoaded{
          __field__: assoc,
          __owner__: assoc_meta.owner,
          __cardinality__: assoc_meta.cardinality
        })
      end)
  end

  describe "users" do
    alias NsukiBusinessService.Accounts.User

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name", verified: true, image: "some image"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", verified: false, image: "some updated image"}
    @invalid_attrs %{first_name: nil, last_name: nil, verified: nil, image: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()

      db_user =
        Accounts.get_user!(user.id)
        |> unload_relations()

      assert db_user == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.verified == true
      assert user.image == "some image"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.verified == false
      assert user.image == "some updated image"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user =
        user_fixture()
        |> unload_relations()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)

      db_user =
        Accounts.get_user!(user.id)
        |> unload_relations()

      assert user == db_user
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "credentials" do
    alias NsukiBusinessService.Accounts.Credential

    @valid_user_attrs %{first_name: "some first_name", last_name: "some last_name", verified: true, image: "some image"}

    @valid_attrs %{
                    email: "some_email@someaddress.com",
                    password_hash: "some password_hash",
                    provider: "some provider",
                    access_token: "some access token",
                    expires_at:  1605560197,
                    refresh_token: "some refresh token",
                    email_verified: true,
                    token_type: "some token type"
                  }
    @update_attrs %{
                     email: "some_updated_email@someaddress.com",
                     password_hash: "some updated password_hash",
                     provider: "some updated provider",
                     token: "some updated token",
                     access_token: "some updated access token",
                     expires_at: 1605560197,
                     refresh_token: "some updated refresh token",
                     email_verified: true,
                     token_type: "some updated token type"
                  }
    @invalid_attrs %{
                       email: nil,
                       password_hash: nil,
                       provider: nil,
                       token: nil,
                       access_token: nil,
                       expires_at: nil,
                       refresh_token: nil,
                       email_verified: nil,
                       token_type: nil
                    }

    def credential_fixture(attrs \\ %{}) do
      {:ok, user} =
        @valid_user_attrs
        |> Accounts.create_user()
    
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_credential(user)

      credential
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = 
        credential_fixture()
        |> unload_relations()

      assert Accounts.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      {:ok, user} =
        @valid_user_attrs
        |> Accounts.create_user()

      assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs, user)
      assert credential.email == "some_email@someaddress.com"
      assert (credential.password_hash == "some password_hash" || credential.password_hash == nil)
      assert credential.provider == "some provider"
      assert credential.access_token == "some access token"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      {:ok, user} =
        @valid_user_attrs
        |> Accounts.create_user()

      assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs, user)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = 
        credential_fixture()
        |> unload_relations()

      assert {:ok, %Credential{} = credential} = Accounts.update_credential(credential, @update_attrs)
      assert credential.email == "some_updated_email@someaddress.com"
      assert (credential.password_hash == "some updated password_hash" || credential.password_hash == nil)
      assert credential.provider == "some updated provider"
      assert credential.access_token == "some updated access token"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = 
        credential_fixture()
        |> unload_relations()

      assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)
      assert credential == Accounts.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    end
  end
end
