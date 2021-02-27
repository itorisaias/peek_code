defmodule PeekCodeGraphql.Schema do
  use Absinthe.Schema

  alias PeekCodeGraphql.Resolvers
  alias PeekCodeGraphql.Schema

  import_types(Schema.Types)
  import AbsintheErrorPayload.Payload
  import_types(AbsintheErrorPayload.ValidationMessageTypes)

  query do
    @desc "Get a list of all orders"
    field :orders, list_of(:order_type) do
      resolve(&Resolvers.OrderResolver.list_orders/3)
    end

    @desc "Get a list of all customers"
    field :customers, list_of(:customer_type) do
      resolve(&Resolvers.CustomerResolver.list_customers/3)
    end
  end

  payload_object(:order_payload, :order_type)
  payload_object(:customer_payload, :customer_type)
  payload_object(:payment_payload, :payment_type)

  mutation do
    @desc "Register a Customer"
    field :create_customer, type: :customer_payload do
      arg(:payload, non_null(:customer_input_type))
      resolve(&Resolvers.CustomerResolver.create_customer/3)
      middleware(&build_payload/2)
    end

    @desc "Register an Order"
    field :create_order, type: :order_payload do
      arg(:payload, non_null(:order_input_type))
      resolve(&Resolvers.OrderResolver.create_order/3)
      middleware(&build_payload/2)
    end

    @desc "Apply a Payment"
    field :apply_payment, type: :payment_payload do
      arg(:payload, non_null(:payment_order_input_type))
      resolve(&Resolvers.PaymentResolver.apply_payment/3)
      middleware(&build_payload/2)
    end
  end
end
