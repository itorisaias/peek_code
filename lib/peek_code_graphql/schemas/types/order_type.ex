defmodule PeekCodeGraphql.Schema.Types.OrderType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: PeekCode.Repo

  object :order_type do
    field :id, :string
    field :balance_due, :float
    field :description, :string
    field :total, :float
    field(:payments, list_of(:payment_type), resolve: assoc(:payments))
  end

  input_object :order_input_type do
    field :description, :string
    field :total, :float
  end
end
