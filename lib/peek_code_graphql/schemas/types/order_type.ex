defmodule PeekCodeGraphql.Schema.Types.OrderType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: PeekCode.Repo

  object :order_type do
    field :id, :string
    field :balance_due, :float
    field :description, :string
    field :customer_id, :string
    field :total, :float
    field :customer, :customer_type, resolve: assoc(:customer)
    field(:payments, list_of(:payment_type), resolve: assoc(:payments))
  end

  input_object :order_input_type do
    field :description, non_null(:string)
    field :customer_id, non_null(:string)
    field :total, non_null(:float)
    field :payments, list_of(:payment_input_type)
  end
end
