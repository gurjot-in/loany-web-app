defmodule BynkLoany.CreditTest do
  use BynkLoany.DataCase

  alias BynkLoany.Credit

  describe "users" do
    alias BynkLoany.Credit.User

    @valid_attrs %{email: "some email", is_approved: true, loan_amount: 42, name: "some name", phone_number: 42, rate_of_interest: 120.5}
    @update_attrs %{email: "some updated email", is_approved: false, loan_amount: 43, name: "some updated name", phone_number: 43, rate_of_interest: 456.7}
    @invalid_attrs %{email: nil, is_approved: nil, loan_amount: nil, name: nil, phone_number: nil, rate_of_interest: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Credit.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Credit.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Credit.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Credit.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.is_approved == true
      assert user.loan_amount == 42
      assert user.name == "some name"
      assert user.phone_number == 42
      assert user.rate_of_interest == 120.5
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Credit.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Credit.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.is_approved == false
      assert user.loan_amount == 43
      assert user.name == "some updated name"
      assert user.phone_number == 43
      assert user.rate_of_interest == 456.7
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Credit.update_user(user, @invalid_attrs)
      assert user == Credit.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Credit.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Credit.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Credit.change_user(user)
    end
  end
end
