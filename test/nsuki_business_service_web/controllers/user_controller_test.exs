defmodule NsukiBusinessServiceWeb.UserControllerTest do
  use NsukiBusinessServiceWeb.ConnCase

  alias NsukiBusinessService.Accounts
  alias NsukiBusinessService.Guardian
  alias NsukiBusinessService.Accounts.User

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    verified: true
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    verified: false
  }
  @invalid_attrs %{first_name: nil, last_name: nil, verified: nil}

  setup do
    {:ok, user} = Accounts.create_user(@create_attrs)
    {:ok, jwt, _claims} = Guardian.encode_and_sign(user)

    conn =
      Phoenix.ConnTest.build_conn()
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{jwt}")

    {:ok, conn: conn, user: user}
  end

  describe "update user" do
    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "verified" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end
end
