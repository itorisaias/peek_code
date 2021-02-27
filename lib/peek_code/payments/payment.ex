defmodule PeekCode.Payment.Payment do
  use Ecto.Schema
  import Ecto.Changeset
  alias PeekCode.Orders.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "payments" do
    field :amount, :float
    field :applied_at, :date
    field :note, :string
    belongs_to :order, Order, foreign_key: :order_id, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount, :applied_at, :note, :order_id])
    |> validate_required([:amount, :applied_at])
  end
end
