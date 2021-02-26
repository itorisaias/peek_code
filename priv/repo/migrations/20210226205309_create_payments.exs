defmodule PeekCode.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :float
      add :applied_at, :date
      add :note, :string
      add :order_id, references(:orders, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      timestamps()
    end

    create index(:payments, [:order_id])
  end
end
