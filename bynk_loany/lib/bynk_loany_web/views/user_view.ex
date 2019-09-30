defmodule BynkLoanyWeb.UserView do
  use BynkLoanyWeb, :view
  alias BynkLoanyWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      phone_number: user.phone_number,
      loan_amount: user.loan_amount,
      is_approved: user.is_approved,
      rate_of_interest: user.rate_of_interest}
  end
end
