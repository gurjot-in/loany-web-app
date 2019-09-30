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
        modified_user_params = Map.put(user_params, "rate_of_interest", rate)
        modified_user_params = Map.put(modified_user_params, "is_approved", true)
        {:ok, %User{} = user} = Credit.create_user(modified_user_params) 
        render(conn, "show.json", user: user)

      {:error, reason}-> 
        IO.inspect "reason of rejection"
        IO.inspect reason
        modified_user_params = Map.put(user_params, "is_approved", false)
        {:ok, %User{} = user} = Credit.create_user(modified_user_params) 
        render(conn, "show.json", user: user)

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
