defmodule NsukiBusinessService.Services do
  @moduledoc """
  The Services context.
  """

  import Ecto.Query, warn: false
  alias NsukiBusinessService.Repo

  alias NsukiBusinessService.Services.Deposit

  @doc """
  Returns the list of deposits.

  ## Examples

      iex> list_deposits()
      [%Deposit{}, ...]

  """
  def list_deposits do
    Repo.all(Deposit)
  end

  @doc """
  Gets a single deposit.

  Raises `Ecto.NoResultsError` if the Deposit does not exist.

  ## Examples

      iex> get_deposit!(123)
      %Deposit{}

      iex> get_deposit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deposit!(id), do: Repo.get!(Deposit, id)

  @doc """
  Creates a deposit.

  ## Examples

      iex> create_deposit(%{field: value})
      {:ok, %Deposit{}}

      iex> create_deposit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deposit(attrs \\ %{}) do
    %Deposit{}
    |> Deposit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deposit.

  ## Examples

      iex> update_deposit(deposit, %{field: new_value})
      {:ok, %Deposit{}}

      iex> update_deposit(deposit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deposit(%Deposit{} = deposit, attrs) do
    deposit
    |> Deposit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deposit.

  ## Examples

      iex> delete_deposit(deposit)
      {:ok, %Deposit{}}

      iex> delete_deposit(deposit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deposit(%Deposit{} = deposit) do
    Repo.delete(deposit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deposit changes.

  ## Examples

      iex> change_deposit(deposit)
      %Ecto.Changeset{source: %Deposit{}}

  """
  def change_deposit(%Deposit{} = deposit) do
    Deposit.changeset(deposit, %{})
  end

  alias NsukiBusinessService.Services.ServiceLocation

  @doc """
  Returns the list of service_locations.

  ## Examples

      iex> list_service_locations()
      [%ServiceLocation{}, ...]

  """
  def list_service_locations do
    Repo.all(ServiceLocation)
  end

  @doc """
  Gets a single service_location.

  Raises `Ecto.NoResultsError` if the Service location does not exist.

  ## Examples

      iex> get_service_location!(123)
      %ServiceLocation{}

      iex> get_service_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_service_location!(id), do: Repo.get!(ServiceLocation, id)

  @doc """
  Creates a service_location.

  ## Examples

      iex> create_service_location(%{field: value})
      {:ok, %ServiceLocation{}}

      iex> create_service_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_service_location(attrs \\ %{}) do
    %ServiceLocation{}
    |> ServiceLocation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a service_location.

  ## Examples

      iex> update_service_location(service_location, %{field: new_value})
      {:ok, %ServiceLocation{}}

      iex> update_service_location(service_location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_service_location(%ServiceLocation{} = service_location, attrs) do
    service_location
    |> ServiceLocation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a service_location.

  ## Examples

      iex> delete_service_location(service_location)
      {:ok, %ServiceLocation{}}

      iex> delete_service_location(service_location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_service_location(%ServiceLocation{} = service_location) do
    Repo.delete(service_location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking service_location changes.

  ## Examples

      iex> change_service_location(service_location)
      %Ecto.Changeset{source: %ServiceLocation{}}

  """
  def change_service_location(%ServiceLocation{} = service_location) do
    ServiceLocation.changeset(service_location, %{})
  end

  alias NsukiBusinessService.Services.Service

  @doc """
  Returns the list of services.

  ## Examples

      iex> list_services()
      [%Service{}, ...]

  """
  def list_services do
    Repo.all(Service)
  end

  @doc """
  Gets a single service.

  Raises `Ecto.NoResultsError` if the Service does not exist.

  ## Examples

      iex> get_service!(123)
      %Service{}

      iex> get_service!(456)
      ** (Ecto.NoResultsError)

  """
  def get_service!(id), do: Repo.get!(Service, id)

  @doc """
  Creates a service.

  ## Examples

      iex> create_service(%{field: value})
      {:ok, %Service{}}

      iex> create_service(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a service.

  ## Examples

      iex> update_service(service, %{field: new_value})
      {:ok, %Service{}}

      iex> update_service(service, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a service.

  ## Examples

      iex> delete_service(service)
      {:ok, %Service{}}

      iex> delete_service(service)
      {:error, %Ecto.Changeset{}}

  """
  def delete_service(%Service{} = service) do
    Repo.delete(service)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking service changes.

  ## Examples

      iex> change_service(service)
      %Ecto.Changeset{source: %Service{}}

  """
  def change_service(%Service{} = service) do
    Service.changeset(service, %{})
  end

  alias NsukiBusinessService.Services.Price

  @doc """
  Returns the list of prices.

  ## Examples

      iex> list_prices()
      [%Price{}, ...]

  """
  def list_prices do
    Repo.all(Price)
  end

  @doc """
  Gets a single price.

  Raises `Ecto.NoResultsError` if the Price does not exist.

  ## Examples

      iex> get_price!(123)
      %Price{}

      iex> get_price!(456)
      ** (Ecto.NoResultsError)

  """
  def get_price!(id), do: Repo.get!(Price, id)

  @doc """
  Creates a price.

  ## Examples

      iex> create_price(%{field: value})
      {:ok, %Price{}}

      iex> create_price(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_price(attrs \\ %{}) do
    %Price{}
    |> Price.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a price.

  ## Examples

      iex> update_price(price, %{field: new_value})
      {:ok, %Price{}}

      iex> update_price(price, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_price(%Price{} = price, attrs) do
    price
    |> Price.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a price.

  ## Examples

      iex> delete_price(price)
      {:ok, %Price{}}

      iex> delete_price(price)
      {:error, %Ecto.Changeset{}}

  """
  def delete_price(%Price{} = price) do
    Repo.delete(price)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking price changes.

  ## Examples

      iex> change_price(price)
      %Ecto.Changeset{source: %Price{}}

  """
  def change_price(%Price{} = price) do
    Price.changeset(price, %{})
  end
end
