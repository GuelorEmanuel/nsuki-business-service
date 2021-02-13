defmodule NsukiBusinessService.ServicesTest do
  use NsukiBusinessService.DataCase

  alias NsukiBusinessService.Services

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

  describe "deposits" do
    alias NsukiBusinessService.Services.Deposit

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def deposit_fixture(attrs \\ %{}) do
      {:ok, deposit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_deposit()

      deposit
    end

    test "list_deposits/0 returns all deposits" do
      deposit = deposit_fixture()
      assert Services.list_deposits() == [deposit]
    end

    test "get_deposit!/1 returns the deposit with given id" do
      deposit = deposit_fixture()
      assert Services.get_deposit!(deposit.id) == deposit
    end

    test "create_deposit/1 with valid data creates a deposit" do
      assert {:ok, %Deposit{} = deposit} = Services.create_deposit(@valid_attrs)
      assert deposit.type == "some type"
    end

    test "create_deposit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_deposit(@invalid_attrs)
    end

    test "update_deposit/2 with valid data updates the deposit" do
      deposit = deposit_fixture()
      assert {:ok, %Deposit{} = deposit} = Services.update_deposit(deposit, @update_attrs)
      assert deposit.type == "some updated type"
    end

    test "update_deposit/2 with invalid data returns error changeset" do
      deposit = deposit_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_deposit(deposit, @invalid_attrs)
      assert deposit == Services.get_deposit!(deposit.id)
    end

    test "delete_deposit/1 deletes the deposit" do
      deposit = deposit_fixture()
      assert {:ok, %Deposit{}} = Services.delete_deposit(deposit)
      assert_raise Ecto.NoResultsError, fn -> Services.get_deposit!(deposit.id) end
    end

    test "change_deposit/1 returns a deposit changeset" do
      deposit = deposit_fixture()
      assert %Ecto.Changeset{} = Services.change_deposit(deposit)
    end
  end

  describe "service_locations" do
    alias NsukiBusinessService.Services.ServiceLocation

    @valid_attrs %{location: "some location"}
    @update_attrs %{location: "some updated location"}
    @invalid_attrs %{location: nil}

    def service_location_fixture(attrs \\ %{}) do
      {:ok, service_location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_service_location()

      service_location
    end

    test "list_service_locations/0 returns all service_locations" do
      service_location = service_location_fixture()
      assert Services.list_service_locations() == [service_location]
    end

    test "get_service_location!/1 returns the service_location with given id" do
      service_location = service_location_fixture()
      assert Services.get_service_location!(service_location.id) == service_location
    end

    test "create_service_location/1 with valid data creates a service_location" do
      assert {:ok, %ServiceLocation{} = service_location} = Services.create_service_location(@valid_attrs)
      assert service_location.location == "some location"
    end

    test "create_service_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_service_location(@invalid_attrs)
    end

    test "update_service_location/2 with valid data updates the service_location" do
      service_location = service_location_fixture()
      assert {:ok, %ServiceLocation{} = service_location} = Services.update_service_location(service_location, @update_attrs)
      assert service_location.location == "some updated location"
    end

    test "update_service_location/2 with invalid data returns error changeset" do
      service_location = service_location_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_service_location(service_location, @invalid_attrs)
      assert service_location == Services.get_service_location!(service_location.id)
    end

    test "delete_service_location/1 deletes the service_location" do
      service_location = service_location_fixture()
      assert {:ok, %ServiceLocation{}} = Services.delete_service_location(service_location)
      assert_raise Ecto.NoResultsError, fn -> Services.get_service_location!(service_location.id) end
    end

    test "change_service_location/1 returns a service_location changeset" do
      service_location = service_location_fixture()
      assert %Ecto.Changeset{} = Services.change_service_location(service_location)
    end
  end

  describe "services" do
    alias NsukiBusinessService.Services.Service
    alias NsukiBusinessService.Businesses
    alias NsukiBusinessService.Accounts

    @valid_attrs %{description: "some description", duration: "2010-04-17T14:00:00Z", name: "some name"}
    @update_attrs %{description: "some updated description", duration: "2011-05-18T15:01:01Z", name: "some updated name"}
    @invalid_attrs %{description: nil, duration: nil, name: nil}

    @valid_user_attrs %{first_name: "some first_name", last_name: "some last_name", verified: true, image: "some image"}
    @valid_business_attrs %{phone_number: "some phone_number", title: "some title"}

    def business_fixture(attrs \\ %{}) do
      {:ok, user} =
        @valid_user_attrs
        |> Accounts.create_user()

      {:ok, business} =
        attrs
        |> Enum.into(@valid_business_attrs)
        |> Businesses.create_business(user)

      business
    end

    def service_fixture(attrs \\ %{}) do
      business = business_fixture()
      service_location = service_location_fixture()

      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_service(business, service_location)

      service
    end

    test "list_services/0 returns all services" do
      service =
        service_fixture()
        |> unload_relations()

      assert Services.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service =
        service_fixture()
        |> unload_relations()

      assert Services.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      business =
        business_fixture()
        |> unload_relations()

      service_location = service_location_fixture()

      assert {:ok, %Service{} = service} = Services.create_service(@valid_attrs, business, service_location)
      assert service.description == "some description"
      assert service.duration == "2010-04-17T14:00:00Z"
      assert service.name == "some name"
    end

    test "create_service/1 with invalid data returns error changeset" do
      business =
        business_fixture()
        |> unload_relations()

      service_location = service_location_fixture()

      assert {:error, %Ecto.Changeset{}} = Services.create_service(@invalid_attrs, business, service_location)
    end

    test "update_service/2 with valid data updates the service" do
      service =
        service_fixture()
        |> unload_relations()

      assert {:ok, %Service{} = service} = Services.update_service(service, @update_attrs)
      assert service.description == "some updated description"
      assert service.duration == "2011-05-18T15:01:01Z"
      assert service.name == "some updated name"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service =
        service_fixture()
        |> unload_relations()

      assert {:error, %Ecto.Changeset{}} = Services.update_service(service, @invalid_attrs)
      assert service == Services.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service =
        service_fixture()
        |> unload_relations()

      assert {:ok, %Service{}} = Services.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Services.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service =
        service_fixture()
        |> unload_relations()

      assert %Ecto.Changeset{} = Services.change_service(service)
    end
  end

  describe "prices" do
    alias NsukiBusinessService.Services.Price

    @valid_attrs %{base_price: "42.89", deposit_price: "42.89", travelling_fee: "42.89"}
    @update_attrs %{base_price: "43", deposit_price: "43", travelling_fee: "43"}
    @invalid_attrs %{base_price: nil, deposit_price: nil, travelling_fee: nil}

    def price_fixture(attrs \\ %{}) do
      service = service_fixture()
      deposit = deposit_fixture()

      {:ok, price} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_price(service, deposit)

      price
    end

    test "list_prices/0 returns all prices" do
      price =
        price_fixture()
        |> unload_relations()

      assert Services.list_prices() == [price]
    end

    test "get_price!/1 returns the price with given id" do
      price =
        price_fixture()
        |> unload_relations()

      assert Services.get_price!(price.id) == price
    end

    test "create_price/1 with valid data creates a price" do
      service = service_fixture()
      deposit = deposit_fixture()

      assert {:ok, %Price{} = price} = Services.create_price(@valid_attrs, service, deposit)
      answeer =  Decimal.new("42.89")

      assert price.base_price == answeer
      assert price.deposit_price == answeer
      assert price.travelling_fee == answeer
    end

    test "create_price/1 with invalid data returns error changeset" do
      service = service_fixture()
      deposit = deposit_fixture()

      assert {:error, %Ecto.Changeset{}} = Services.create_price(@invalid_attrs, service, deposit)
    end

    test "update_price/2 with valid data updates the price" do
      price = price_fixture()
      assert {:ok, %Price{} = price} = Services.update_price(price, @update_attrs)
      answeer =  Decimal.new("43")

      assert price.base_price == answeer
      assert price.deposit_price == answeer
      assert price.travelling_fee == answeer
    end

    test "update_price/2 with invalid data returns error changeset" do
      price =
        price_fixture()
        |> unload_relations()

      assert {:error, %Ecto.Changeset{}} = Services.update_price(price, @invalid_attrs)
      assert price == Services.get_price!(price.id)
    end

    test "delete_price/1 deletes the price" do
      price = price_fixture()
      assert {:ok, %Price{}} = Services.delete_price(price)
      assert_raise Ecto.NoResultsError, fn -> Services.get_price!(price.id) end
    end

    test "change_price/1 returns a price changeset" do
      price = price_fixture()
      assert %Ecto.Changeset{} = Services.change_price(price)
    end
  end
end
