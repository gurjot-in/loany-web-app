defmodule BynkLoanyWeb.UserControllerTest do
  use BynkLoanyWeb.ConnCase

  alias BynkLoany.Credit
  alias BynkLoany.Credit.User

  @create_attrs %{
    email: "some email",
    is_approved: true,
    loan_amount: 42,
    name: "some name",
    phone_number: 42,
    rate_of_interest: 120.5
  }
  @update_attrs %{
    email: "some updated email",
    is_approved: false,
    loan_amount: 43,
    name: "some updated name",
    phone_number: 43,
    rate_of_interest: 456.7
  }
  @invalid_attrs %{email: nil, is_approved: nil, loan_amount: nil, name: nil, phone_number: nil, rate_of_interest: nil}

  def fixture(:user) do
    {:ok, user} = Credit.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "is_approved" => true,
               "loan_amount" => 42,
               "name" => "some name",
               "phone_number" => 42,
               "rate_of_interest" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "is_approved" => false,
               "loan_amount" => 43,
               "name" => "some updated name",
               "phone_number" => 43,
               "rate_of_interest" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
