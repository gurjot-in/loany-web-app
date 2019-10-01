defmodule BynkLoany.Repo.Migrations.ChangePhoneDatatype do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :phone_number, :string
    end
  end
end
