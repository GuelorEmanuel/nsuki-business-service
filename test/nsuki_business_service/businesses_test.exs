defmodule NsukiBusinessService.BusinessesTest do
  use NsukiBusinessService.DataCase

  alias NsukiBusinessService.Businesses

  describe "businesses" do
    alias NsukiBusinessService.Businesses.Business

    @valid_attrs %{phone_number: "some phone_number", title: "some title"}
    @update_attrs %{phone_number: "some updated phone_number", title: "some updated title"}
    @invalid_attrs %{phone_number: nil, title: nil}

    def business_fixture(attrs \\ %{}) do
      {:ok, business} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Businesses.create_business()

      business
    end

    test "list_businesses/0 returns all businesses" do
      business = business_fixture()
      assert Businesses.list_businesses() == [business]
    end

    test "get_business!/1 returns the business with given id" do
      business = business_fixture()
      assert Businesses.get_business!(business.id) == business
    end

    test "create_business/1 with valid data creates a business" do
      assert {:ok, %Business{} = business} = Businesses.create_business(@valid_attrs)
      assert business.phone_number == "some phone_number"
      assert business.title == "some title"
    end

    test "create_business/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Businesses.create_business(@invalid_attrs)
    end

    test "update_business/2 with valid data updates the business" do
      business = business_fixture()
      assert {:ok, %Business{} = business} = Businesses.update_business(business, @update_attrs)
      assert business.phone_number == "some updated phone_number"
      assert business.title == "some updated title"
    end

    test "update_business/2 with invalid data returns error changeset" do
      business = business_fixture()
      assert {:error, %Ecto.Changeset{}} = Businesses.update_business(business, @invalid_attrs)
      assert business == Businesses.get_business!(business.id)
    end

    test "delete_business/1 deletes the business" do
      business = business_fixture()
      assert {:ok, %Business{}} = Businesses.delete_business(business)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_business!(business.id) end
    end

    test "change_business/1 returns a business changeset" do
      business = business_fixture()
      assert %Ecto.Changeset{} = Businesses.change_business(business)
    end
  end

  describe "addresses" do
    alias NsukiBusinessService.Businesses.Address

    @valid_attrs %{apt_no: "some apt_no", postal_code: "some postal_code", province_state: "some province_state", street_no: "some street_no"}
    @update_attrs %{apt_no: "some updated apt_no", postal_code: "some updated postal_code", province_state: "some updated province_state", street_no: "some updated street_no"}
    @invalid_attrs %{apt_no: nil, postal_code: nil, province_state: nil, street_no: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Businesses.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Businesses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Businesses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Businesses.create_address(@valid_attrs)
      assert address.apt_no == "some apt_no"
      assert address.postal_code == "some postal_code"
      assert address.province_state == "some province_state"
      assert address.street_no == "some street_no"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Businesses.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Businesses.update_address(address, @update_attrs)
      assert address.apt_no == "some updated apt_no"
      assert address.postal_code == "some updated postal_code"
      assert address.province_state == "some updated province_state"
      assert address.street_no == "some updated street_no"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Businesses.update_address(address, @invalid_attrs)
      assert address == Businesses.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Businesses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Businesses.change_address(address)
    end
  end
end
