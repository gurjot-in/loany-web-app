defmodule BynkLoanyWeb.UserController do
  use BynkLoanyWeb, :controller

  alias BynkLoany.Credit
  alias BynkLoany.Credit.User
  alias BynkLoany.Credit.Algo

  action_fallback BynkLoanyWeb.FallbackController

  def index(conn, _params) do
    users = Credit.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    user_params = User.sanitize_user_data(user_params)
    IO.inspect user_params
    loan_amount = user_params["loan_amount"]
    
    case Algo.application_review(loan_amount) do
      {:ok, rate} ->  
        user_params = Map.merge(user_params, %{"is_approved" => true, "rate_of_interest" => rate})
        with {:ok, %User{} = user} <- Credit.create_user(user_params) do
          render(conn, "show.json", user: user)
        end

      {:error, reason}-> 
        IO.inspect "reason of rejection"
        IO.inspect reason
        user_params = Map.merge(user_params, %{"is_approved" => false})
        with {:ok, %User{} = user} <- Credit.create_user(user_params) do
          render(conn, "show.json", user: user)
        end

    end


  end

  def show(conn, %{"id" => id}) do
    user = Credit.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Credit.get_user!(id)
    Cachex.reset(:my_cache)
    with {:ok, %User{} = user} <- Credit.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Credit.get_user!(id)
    Cachex.reset(:my_cache)
    with {:ok, %User{}} <- Credit.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
