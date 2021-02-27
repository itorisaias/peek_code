defmodule PeekCodeGraphql.Schema.Types.CustomerType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: PeekCode.Repo

  object :customer_type do
    field :id, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field(:orders, list_of(:order_type), resolve: assoc(:orders))
  end

  input_object :customer_input_type do
    field :email, non_null(:string)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
  end
end
