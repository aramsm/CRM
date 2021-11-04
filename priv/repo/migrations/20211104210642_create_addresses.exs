defmodule Iza.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add(:street, :string, null: false)
      add(:city, :string, null: false)
      add(:state, :string, null: false)
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end
  end
end
