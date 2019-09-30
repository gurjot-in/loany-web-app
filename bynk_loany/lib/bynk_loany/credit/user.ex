defmodule BynkLoany.Credit.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :is_approved, :boolean, default: false
    field :loan_amount, :integer
    field :name, :string
    field :phone_number, :integer
    field :rate_of_interest, :float

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone_number, :loan_amount, :is_approved, :rate_of_interest])
    |> validate_required([:name, :email, :phone_number, :loan_amount, :is_approved, :rate_of_interest])
  end
end
