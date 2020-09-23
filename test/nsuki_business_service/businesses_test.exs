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
end
