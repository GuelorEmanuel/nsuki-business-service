defmodule NsukiBusinessServiceWeb.BusinessControllerTest do
  use NsukiBusinessServiceWeb.ConnCase

  alias NsukiBusinessService.Businesses
  alias NsukiBusinessService.Businesses.Business
  alias NsukiBusinessService.Guardian
  alias NsukiBusinessService.Accounts

  @create_attrs %{
    title: "some title",
    phone_number: "some phone_number",
  }
  @update_attrs %{
    title: "some updated title",
    phone_number: "some updated phone_number"
  }
  @invalid_attrs %{title: nil, phone_number: nil}

  @create_user_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    verified: true,
    image: "some image"
  }

  def fixture(:business) do
    {:ok, business} = Businesses.create_business(@create_attrs)
    business
  end

  setup %{conn: conn} do
    {:ok, user} = Accounts.create_user(@create_user_attrs)
    {:ok, jwt, _claims} = Guardian.encode_and_sign(user)

    conn =
      Phoenix.ConnTest.build_conn()
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{jwt}")

    {:ok, conn: conn, user: user}
  end

  describe "index" do
    test "lists all businesses", %{conn: conn} do
      conn = get(conn, Routes.business_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create business" do
    test "renders business when data is valid", %{conn: conn} do
      conn = post(conn, Routes.business_path(conn, :create), business: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.business_path(conn, :show, id))

      assert %{
               "id" => id,
               "title" => "some title",
               "phone_number" => "some phone_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.business_path(conn, :create), business: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  # describe "update business" do
  #   setup [:create_business]

  #   test "renders business when data is valid", %{conn: conn, business: %Business{id: id} = business} do
  #     conn = put(conn, Routes.business_path(conn, :update, business), business: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.business_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "title" => "some updated title",
  #              "phone_number" => "some updated phone_number"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, business: business} do
  #     conn = put(conn, Routes.business_path(conn, :update, business), business: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete service" do
  #   setup [:create_business]

  #   test "deletes chosen service", %{conn: conn, business: business} do
  #     conn = delete(conn, Routes.business_path(conn, :delete, business))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.business_path(conn, :show, business))
  #     end
  #   end
  # end

  defp create_business(_) do
    business = fixture(:business)
    {:ok, business: business}
  end
end
