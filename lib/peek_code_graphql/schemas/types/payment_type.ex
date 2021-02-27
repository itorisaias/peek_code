defmodule PeekCodeGraphql.Schema.Types.PaymentType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: PeekCode.Repo

  object :payment_type do
    field :id, :string
    field :order_id, non_null(:string)
    field :order, :order_type, resolve: assoc(:order)
    field :amount, :float
    field :applied_at, :string
    field :note, :string
  end

  input_object :payment_order_input_type do
    field :order_id, non_null(:string)
    field :amount, non_null(:float)
    field :applied_at, non_null(:string)
    field :note, :string
  end

  input_object :payment_input_type do
    field :amount, non_null(:float)
    field :applied_at, non_null(:string)
    field :note, non_null(:string)
  end
end
