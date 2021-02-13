defmodule NsukiBusinessService.Businesses do
  @moduledoc """
  The Businesses context.
  """

  import Ecto.Query, warn: false
  alias NsukiBusinessService.Repo

  alias NsukiBusinessService.Businesses.CountryCode
  alias NsukiBusinessService.Services
  alias NsukiBusinessService.Accounts

  @doc """
  Returns the list of country_code.

  ## Examples

      iex> list_country_code()
      [%CountryCode{}, ...]

  """
  def list_country_code do
    Repo.all(CountryCode)
  end

  @doc """
  Gets a single country_code.

  Raises `Ecto.NoResultsError` if the Country code does not exist.

  ## Examples

      iex> get_country_code!(123)
      %CountryCode{}

      iex> get_country_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country_code!(id), do: Repo.get!(CountryCode, id)

  @doc """
  Creates a country_code.

  ## Examples

      iex> create_country_code(%{field: value})
      {:ok, %CountryCode{}}

      iex> create_country_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country_code(attrs \\ %{}) do
    %CountryCode{}
    |> CountryCode.changeset(attrs)
    |> Repo.insert()
  end

  def create_country_code!(attrs \\ %{}) do
    %CountryCode{}
    |> CountryCode.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a country_code.

  ## Examples

      iex> update_country_code(country_code, %{field: new_value})
      {:ok, %CountryCode{}}

      iex> update_country_code(country_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country_code(%CountryCode{} = country_code, attrs) do
    country_code
    |> CountryCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a country_code.

  ## Examples

      iex> delete_country_code(country_code)
      {:ok, %CountryCode{}}

      iex> delete_country_code(country_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country_code(%CountryCode{} = country_code) do
    Repo.delete(country_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country_code changes.

  ## Examples

      iex> change_country_code(country_code)
      %Ecto.Changeset{source: %CountryCode{}}

  """
  def change_country_code(%CountryCode{} = country_code) do
    CountryCode.changeset(country_code, %{})
  end


  alias NsukiBusinessService.Businesses.Business

  @doc """
  Returns the list of businesses.

  ## Examples

      iex> list_businesses()
      [%Business{}, ...]

  """
  def list_businesses do
    Repo.all(Business)
  end

  @doc """
  Gets a single business.

  Raises `Ecto.NoResultsError` if the Business does not exist.

  ## Examples

      iex> get_business!(123)
      %Business{}

      iex> get_business!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business!(id), do: Repo.get!(Business, id)

  def get_business_by_user(user) do
    query =
      from b in Business,
      inner_join: u in assoc(b, :user),
      where: u.id == ^user.id

    query
    |> Repo.one()
  end

  @doc """
  Creates a business.

  ## Examples

      iex> create_business(%{field: value})
      {:ok, %Business{}}

      iex> create_business(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business(attrs \\ %{}, user) do
    %Business{}
    |> Business.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def create_business!(attrs \\ %{}, user) do
    business =
      %Business{}
      |> Business.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:user, user)
       |> Repo.insert!()

    {:ok, business}
  end

  def create_business_on_boarding(attrs \\ %{}, user) do
    Repo.transaction(fn ->
      with {:ok, business} <- create_business!(attrs["business"], user),
           {:ok, _calendar} <- create_calendar!(attrs["calendar"], business),
           {:ok, country} <- get_country_by_name!(attrs["country"].name),
           {:ok, _address} <- create_address(attrs["address"], business, country),
           {:ok, service_location} <- Services.get_service_location_by_name!(attrs["service_location"]),
           {:ok, service} <- Services.create_service!(attrs["service"], business, service_location),
           {:ok, deposit} <- Services.get_deposit_by_name!(attrs["deposit_type"]),
           {:ok, _price} <- Services.create_price!(attrs["price"], service, deposit),
           {:ok, _user} <- Accounts.update_user!(user, %{verified: true})
      do
        business
      else
        {:error, _value} -> IO.puts("Create business onboarding failed")
      end
    end)
  end

  @doc """
  Updates a business.

  ## Examples

      iex> update_business(business, %{field: new_value})
      {:ok, %Business{}}

      iex> update_business(business, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business(%Business{} = business, attrs) do
    business
    |> Business.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a business.

  ## Examples

      iex> delete_business(business)
      {:ok, %Business{}}

      iex> delete_business(business)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business(%Business{} = business) do
    Repo.delete(business)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business changes.

  ## Examples

      iex> change_business(business)
      %Ecto.Changeset{source: %Business{}}

  """
  def change_business(%Business{} = business) do
    Business.changeset(business, %{})
  end


  alias NsukiBusinessService.Businesses.Calendar

  @doc """
  Returns the list of calendars.

  ## Examples

      iex> list_calendars()
      [%Calendar{}, ...]

  """
  def list_calendars do
    Repo.all(Calendar)
  end

  @doc """
  Gets a single calendar.

  Raises `Ecto.NoResultsError` if the Calendar does not exist.

  ## Examples

      iex> get_calendar!(123)
      %Calendar{}

      iex> get_calendar!(456)
      ** (Ecto.NoResultsError)

  """
  def get_calendar!(id), do: Repo.get!(Calendar, id)

  @doc """
  Creates a calendar.

  ## Examples

      iex> create_calendar(%{field: value})
      {:ok, %Calendar{}}

      iex> create_calendar(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_calendar(attrs \\ %{}, business) do
    %Calendar{}
    |> Calendar.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:business, business)
    |> Repo.insert()
  end

  def create_calendar!(attrs \\ %{}, business) do
    calendar =
      %Calendar{}
      |> Calendar.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:business, business)
      |> Repo.insert!()

      {:ok, calendar}
  end

  @doc """
  Updates a calendar.

  ## Examples

      iex> update_calendar(calendar, %{field: new_value})
      {:ok, %Calendar{}}

      iex> update_calendar(calendar, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_calendar(%Calendar{} = calendar, attrs) do
    calendar
    |> Calendar.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a calendar.

  ## Examples

      iex> delete_calendar(calendar)
      {:ok, %Calendar{}}

      iex> delete_calendar(calendar)
      {:error, %Ecto.Changeset{}}

  """
  def delete_calendar(%Calendar{} = calendar) do
    Repo.delete(calendar)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking calendar changes.

  ## Examples

      iex> change_calendar(calendar)
      %Ecto.Changeset{source: %Calendar{}}

  """
  def change_calendar(%Calendar{} = calendar) do
    Calendar.changeset(calendar, %{})
  end


  alias NsukiBusinessService.Businesses.Country

  @doc """
  Returns the list of countries.

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  def list_countries do
    Repo.all(Country)
  end

  @doc """
  Gets a single country.

  Raises `Ecto.NoResultsError` if the Country does not exist.

  ## Examples

      iex> get_country!(123)
      %Country{}

      iex> get_country!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country!(id), do: Repo.get!(Country, id)

  def get_country_by_name!(name) do
    name = String.upcase(name)

    query =
      from c in Country,
      where: c.name == ^name

    query_result =
      query
      |> Repo.one!()
      |> Repo.preload(:country_code)

    {:ok, query_result}
  end

  @doc """
  Creates a country.

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country(attrs \\ %{}, country_code) do
    %Country{}
    |> Country.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:country_code, country_code)
    |> Repo.insert()
  end

  def create_country!(attrs \\ %{}, country_code) do
    %Country{}
    |> Country.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:country_code, country_code)
    |> Repo.insert!()
  end

  @doc """
  Updates a country.

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a country.

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country(%Country{} = country) do
    Repo.delete(country)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{source: %Country{}}

  """
  def change_country(%Country{} = country) do
    Country.changeset(country, %{})
  end


  alias NsukiBusinessService.Businesses.Address

  @doc """
  Returns the list of addresses.

  ## Examples

      iex> list_addresses()
      [%Address{}, ...]

  """
  def list_addresses do
    Repo.all(Address)
  end

  @doc """
  Gets a single address.

  Raises `Ecto.NoResultsError` if the Address does not exist.

  ## Examples

      iex> get_address!(123)
      %Address{}

      iex> get_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_address!(id), do: Repo.get!(Address, id)

  @doc """
  Creates a address.

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_address(attrs \\ %{}, business, country) do
    %Address{}
    |> Address.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:business, business)
    |> Ecto.Changeset.put_assoc(:country, country)
    |> Repo.insert()
  end

  def create_address!(attrs \\ %{}, business, country) do
    address=
      %Address{}
      |> Address.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:business, business)
      |> Ecto.Changeset.put_assoc(:country, country)
      |> Repo.insert!()

    {:ok, address}
  end

  @doc """
  Updates a address.

  ## Examples

      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}

      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a address.

  ## Examples

      iex> delete_address(address)
      {:ok, %Address{}}

      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_address(%Address{} = address) do
    Repo.delete(address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking address changes.

  ## Examples

      iex> change_address(address)
      %Ecto.Changeset{source: %Address{}}

  """
  def change_address(%Address{} = address) do
    Address.changeset(address, %{})
  end
end
