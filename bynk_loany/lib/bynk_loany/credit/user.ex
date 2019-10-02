defmodule BynkLoany.Credit.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :is_approved, :boolean, default: false
    field :loan_amount, :integer
    field :name, :string
    field :phone_number, :string
    field :rate_of_interest, :float

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone_number, :loan_amount, :is_approved, :rate_of_interest])
    |> validate_format(:email, ~r/@/)
    |> validate_required([:name, :email, :phone_number, :loan_amount, :is_approved])
    |> validate_number(:loan_amount, less_than: 999999999)
    |> validate_length(:phone_number, max: 10)
  end

  def sanitize_user_data(attrs) do
    # IO.inspect is_integer(attrs["loan_amount"])
    # IO.inspect is_integer(attrs["phone_number"])

    # case is_integer(attrs["loan_amount"]) do
    #   true -> 
    #     {:ok}
    #   false -> 
    #     {loan_amount, rem} = Integer.parse(attrs["loan_amount"])
    #     IO.inspect "trans"
    #     IO.inspect loan_amount
    #     attrs = Map.put(attrs, "loan_amount", loan_amount)
    #     IO.inspect "final attrs"
    #     IO.inspect attrs
    # end

    # case is_integer(attrs["phone_number"]) do
    #   true -> 
    #     {:ok}
    #   false -> 
    #     {phone_number, rem} = Integer.parse(attrs["phone_number"])
    #     attrs = Map.put(attrs, "phone_number", phone_number)
    # end

    # IO.inspect "attrs"
    # IO.inspect attrs
    # attrs
    {loan_amount, _} = :string.to_integer(to_charlist(attrs["loan_amount"]))

    Map.merge(attrs, %{"loan_amount" => loan_amount})

  end

end