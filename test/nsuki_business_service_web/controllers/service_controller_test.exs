defmodule NsukiBusinessServiceWeb.ServiceControllerTest do
  use NsukiBusinessServiceWeb.ConnCase

  alias NsukiBusinessService.Services
  alias NsukiBusinessService.Services.Service
  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.Guardian


  @create_attrs %{
    description: "some description",
    duration: ~T[14:00:00],
    name: "some name"
  }

  @create_user %{
    first_name: "some first_name",
    last_name: "some last_name",
    verified: true
  }

  @update_attrs %{
    description: "some updated description",
    duration: ~T[15:01:01],
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, duration: nil, name: nil}

  def fixture(:service) do
    {:ok, service} = Services.create_service(@create_attrs)
    service
  end

  setup do
    {:ok, user} = Accounts.create_user(@create_user)
    {:ok, jwt, _claims} = Guardian.encode_and_sign(user)

    conn =
      Phoenix.ConnTest.build_conn()
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{jwt}")

    {:ok, conn: conn, user: user}
  end

  describe "index" do
    test "lists all services", %{conn: conn} do
      conn = get(conn, Routes.service_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create service" do
    test "renders service when data is valid", %{conn: conn} do
      conn = post(conn, Routes.service_path(conn, :create), service: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.service_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "duration" => "14:00:00",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.service_path(conn, :create), service: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update service" do
    setup [:create_service]

    test "renders service when data is valid", %{conn: conn, service: %Service{id: id} = service} do
      conn = put(conn, Routes.service_path(conn, :update, service), service: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.service_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "duration" => "15:01:01",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, service: service} do
      conn = put(conn, Routes.service_path(conn, :update, service), service: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete service" do
    setup [:create_service]

    test "deletes chosen service", %{conn: conn, service: service} do
      conn = delete(conn, Routes.service_path(conn, :delete, service))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.service_path(conn, :show, service))
      end
    end
  end

  defp create_service(_) do
    service = fixture(:service)
    {:ok, service: service}
  end
end
