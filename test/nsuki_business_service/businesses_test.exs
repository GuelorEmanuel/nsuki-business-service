defmodule NsukiBusinessService.BusinessesTest do
  use NsukiBusinessService.DataCase

  alias NsukiBusinessService.Businesses
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

  describe "businesses" do
    alias NsukiBusinessService.Businesses.Business

    @valid_attrs %{phone_number: "some phone_number", title: "some title"}
    @update_attrs %{phone_number: "some updated phone_number", title: "some updated title"}
    @invalid_attrs %{phone_number: nil, title: nil}

    @valid_user_attrs %{first_name: "some first_name", last_name: "some last_name", verified: true, image: "some image"}

    def business_fixture(attrs \\ %{}) do
      {:ok, user} =
        @valid_user_attrs
        |> Accounts.create_user()

      {:ok, business} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Businesses.create_business(user)

      business
    end

    test "list_businesses/0 returns all businesses" do
      business =
        business_fixture()
        |> unload_relations()

      assert Businesses.list_businesses() == [business]
    end

    test "get_business!/1 returns the business with given id" do
      business =
        business_fixture()
        |> unload_relations()

      assert Businesses.get_business!(business.id) == business
    end

    test "create_business/1 with valid data creates a business" do
      {:ok, user} =
        @valid_user_attrs
        |> Accounts.create_user()

      assert {:ok, %Business{} = business} = Businesses.create_business(@valid_attrs, user)
      assert business.phone_number == "some phone_number"
      assert business.title == "some title"
    end

    test "create_business/1 with invalid data returns error changeset" do
      {:ok, user} =
        @valid_user_attrs
        |> Accounts.create_user()

      assert {:error, %Ecto.Changeset{}} = Businesses.create_business(@invalid_attrs, user)
    end

    test "update_business/2 with valid data updates the business" do
      business = business_fixture()
      assert {:ok, %Business{} = business} = Businesses.update_business(business, @update_attrs)
      assert business.phone_number == "some updated phone_number"
      assert business.title == "some updated title"
    end

    test "update_business/2 with invalid data returns error changeset" do
      business =
        business_fixture()
        |> unload_relations()

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


  describe "calendars" do
    alias NsukiBusinessService.Businesses.Calendar

    @valid_attrs %{google_id: "some google_id", summary: "some summary", time_zone: "some time_zone"}
    @update_attrs %{google_id: "some updated google_id", summary: "some updated summary", time_zone: "some updated time_zone"}
    @invalid_attrs %{google_id: nil, summary: nil, time_zone: nil}

    def calendar_fixture(attrs \\ %{}) do
      business =
        business_fixture()

      {:ok, calendar} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Businesses.create_calendar(business)

      calendar
    end

    test "list_calendars/0 returns all calendars" do
      calendar =
        calendar_fixture()
        |> unload_relations()

      assert Businesses.list_calendars() == [calendar]
    end

    test "get_calendar!/1 returns the calendar with given id" do
      calendar =
        calendar_fixture()
        |> unload_relations()

      assert Businesses.get_calendar!(calendar.id) == calendar
    end

    test "create_calendar/1 with valid data creates a calendar" do
      business =
        business_fixture()

      assert {:ok, %Calendar{} = calendar} = Businesses.create_calendar(@valid_attrs, business)
      assert calendar.google_id == "some google_id"
      assert calendar.summary == "some summary"
      assert calendar.time_zone == "some time_zone"
    end

    test "create_calendar/1 with invalid data returns error changeset" do
      business =
        business_fixture()

      assert {:error, %Ecto.Changeset{}} = Businesses.create_calendar(@invalid_attrs, business)
    end

    test "update_calendar/2 with valid data updates the calendar" do
      calendar = calendar_fixture()
      assert {:ok, %Calendar{} = calendar} = Businesses.update_calendar(calendar, @update_attrs)
      assert calendar.google_id == "some updated google_id"
      assert calendar.summary == "some updated summary"
      assert calendar.time_zone == "some updated time_zone"
    end

    test "update_calendar/2 with invalid data returns error changeset" do
      calendar =
        calendar_fixture()
        |> unload_relations()

      assert {:error, %Ecto.Changeset{}} = Businesses.update_calendar(calendar, @invalid_attrs)
      assert calendar == Businesses.get_calendar!(calendar.id)
    end

    test "delete_calendar/1 deletes the calendar" do
      calendar = calendar_fixture()
      assert {:ok, %Calendar{}} = Businesses.delete_calendar(calendar)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_calendar!(calendar.id) end
    end

    test "change_calendar/1 returns a calendar changeset" do
      calendar = calendar_fixture()
      assert %Ecto.Changeset{} = Businesses.change_calendar(calendar)
    end
  end

  describe "country_codes" do
    alias NsukiBusinessService.Businesses.CountryCode

    @valid_attrs %{code: 01}
    @update_attrs %{code: 02}
    @invalid_attrs %{code: nil}

    def country_code_fixture(attrs \\ %{}) do
      {:ok, country_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Businesses.create_country_code()

      country_code
    end

    test "list_country_code/0 returns all country_code" do
      country_code = country_code_fixture()
      assert Businesses.list_country_code() == [country_code]
    end

    test "get_country_code!/1 returns the country_code with given id" do
      country_code = country_code_fixture()
      assert Businesses.get_country_code!(country_code.id) == country_code
    end

    test "create_country_code/1 with valid data creates a country_code" do
      assert {:ok, %CountryCode{} = country_code} = Businesses.create_country_code(@valid_attrs)
      assert country_code.code == 01
    end

    test "create_country_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Businesses.create_country_code(@invalid_attrs)
    end

    test "update_country_code/2 with valid data updates the country_code" do
      country_code = country_code_fixture()
      assert {:ok, %CountryCode{} = country_code} = Businesses.update_country_code(country_code, @update_attrs)
      assert country_code.code == 02
    end

    test "update_country_code/2 with invalid data returns error changeset" do
      country_code = country_code_fixture()
      assert {:error, %Ecto.Changeset{}} = Businesses.update_country_code(country_code, @invalid_attrs)
      assert country_code == Businesses.get_country_code!(country_code.id)
    end

    test "delete_country_code/1 deletes the country_code" do
      country_code = country_code_fixture()
      assert {:ok, %CountryCode{}} = Businesses.delete_country_code(country_code)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_country_code!(country_code.id) end
    end

    test "change_country_code/1 returns a country_code changeset" do
      country_code = country_code_fixture()
      assert %Ecto.Changeset{} = Businesses.change_country_code(country_code)
    end
  end


  describe "countries" do
    alias NsukiBusinessService.Businesses.Country

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def country_fixture(attrs \\ %{}) do
      country_code = country_code_fixture()

      {:ok, country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Businesses.create_country(country_code)

      country
    end

    test "list_countries/0 returns all countries" do
      country =
        country_fixture()
        |> unload_relations()

      assert Businesses.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country =
        country_fixture()
        |> unload_relations()

      assert Businesses.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      country_code = country_code_fixture()

      assert {:ok, %Country{} = country} = Businesses.create_country(@valid_attrs, country_code)
      assert country.name == "some name"
    end

    test "create_country/1 with invalid data returns error changeset" do
      country_code = country_code_fixture()

      assert {:error, %Ecto.Changeset{}} = Businesses.create_country(@invalid_attrs, country_code)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      assert {:ok, %Country{} = country} = Businesses.update_country(country, @update_attrs)
      assert country.name == "some updated name"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country =
        country_fixture()
        |> unload_relations()

      assert {:error, %Ecto.Changeset{}} = Businesses.update_country(country, @invalid_attrs)
      assert country == Businesses.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Businesses.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Businesses.change_country(country)
    end
  end


  describe "addresses" do
    alias NsukiBusinessService.Businesses.Address

    @valid_attrs %{apt_no: "some apt_no", postal_code: "some postal_code", province_state: "some province_state", street_no: "some street_no"}
    @update_attrs %{apt_no: "some updated apt_no", postal_code: "some updated postal_code", province_state: "some updated province_state", street_no: "some updated street_no"}
    @invalid_attrs %{apt_no: nil, postal_code: nil, province_state: nil, street_no: nil}

    def address_fixture(attrs \\ %{}) do
      business =
        business_fixture()

      country =
        country_fixture()


      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Businesses.create_address(business, country)

      address
    end

    test "list_addresses/0 returns all addresses" do
      address =
        address_fixture()
        |> unload_relations()

      assert Businesses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address =
        address_fixture()
        |> unload_relations()

      assert Businesses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      business =
        business_fixture()

      country =
        country_fixture()

      assert {:ok, %Address{} = address} = Businesses.create_address(@valid_attrs, business, country)
      assert address.apt_no == "some apt_no"
      assert address.postal_code == "some postal_code"
      assert address.province_state == "some province_state"
      assert address.street_no == "some street_no"
    end

    test "create_address/1 with invalid data returns error changeset" do
      business =
        business_fixture()

      country =
        country_fixture()

      assert {:error, %Ecto.Changeset{}} = Businesses.create_address(@invalid_attrs, business, country)
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
      address =
        address_fixture()
        |> unload_relations()

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
