defmodule BynkLoany.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :phone_number, :integer
      add :loan_amount, :integer
      add :is_approved, :boolean, default: false, null: false
      add :rate_of_interest, :float

      timestamps()
    end

  end
end
