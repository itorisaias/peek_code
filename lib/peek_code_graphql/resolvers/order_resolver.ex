defmodule PeekCodeGraphql.Resolvers.OrderResolver do
  alias PeekCode.Orders

  def list_orders(_, _, _), do: {:ok, Orders.list_orders()}
  def create_order(_, %{payload: payload}, _), do: Orders.create_order(payload)
end
