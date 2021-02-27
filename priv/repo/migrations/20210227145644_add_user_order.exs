defmodule PeekCode.Repo.Migrations.AddUserOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :customer_id,
          references(:customers, on_delete: :delete_all, on_update: :update_all, type: :binary_id)
    end
  end
end
