defmodule PeekCode.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias PeekCode.Payment.Payment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :balance_due, :float, default: 0.0
    field :description, :string
    field :total, :float

    has_many :payments, Payment

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    attrs = Map.put(attrs, :balance_due, get_balance_due(attrs))

    order
    |> cast(attrs, [:description, :total, :balance_due])
    |> validate_required([:description, :total, :balance_due])
    |> cast_assoc(:payments, with: &Payment.changeset/2)
  end

  @doc false
  def update_balance_due(order, %{amount: amount}) do
    attrs = %{balance_due: order.balance_due - amount}

    order
    |> cast(attrs, [:description, :total, :balance_due])
    |> validate_required([:description, :total, :balance_due])
  end

  defp get_balance_due(order) do
    order
    |> Map.has_key?(:payments)
    |> case do
      true ->
        order.total - (order.payments |> Enum.map(& &1.amount) |> Enum.sum())

      false ->
        order.total
    end
  end
end
