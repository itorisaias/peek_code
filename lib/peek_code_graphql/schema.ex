defmodule PeekCodeGraphql.Schema do
  use Absinthe.Schema

  alias PeekCodeGraphql.Resolvers
  alias PeekCodeGraphql.Schema

  import_types(Schema.Types)
  # import AbsintheErrorPayload.Payload
  # import_types(AbsintheErrorPayload.ValidationMessage)

  query do
    @desc "Get a list of all orders"
    field :orders, list_of(:order_type) do
      resolve(&Resolvers.OrderResolver.list_orders/3)
    end
  end

  mutation do
    @desc "Register an Order"
    field :create_order, type: :order_type do
      arg(:payload, non_null(:order_input_type))
      resolve(&Resolvers.OrderResolver.create_order/3)
    end
  end
end
