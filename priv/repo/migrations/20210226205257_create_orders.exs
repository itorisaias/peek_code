defmodule PeekCode.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text
      add :total, :float
      add :balance_due, :float

      timestamps()
    end

  end
end
