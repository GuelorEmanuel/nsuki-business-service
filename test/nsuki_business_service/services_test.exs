defmodule NsukiBusinessService.ServicesTest do
  use NsukiBusinessService.DataCase

  alias NsukiBusinessService.Services

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

    @valid_attrs %{description: "some description", duration: "2010-04-17T14:00:00Z", name: "some name"}
    @update_attrs %{description: "some updated description", duration: "2011-05-18T15:01:01Z", name: "some updated name"}
    @invalid_attrs %{description: nil, duration: nil, name: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_service()

      service
    end

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Services.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Services.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = Services.create_service(@valid_attrs)
      assert service.description == "some description"
      assert service.duration == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert service.name == "some name"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, %Service{} = service} = Services.update_service(service, @update_attrs)
      assert service.description == "some updated description"
      assert service.duration == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert service.name == "some updated name"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_service(service, @invalid_attrs)
      assert service == Services.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Services.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Services.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Services.change_service(service)
    end
  end
end
