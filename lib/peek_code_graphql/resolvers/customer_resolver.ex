defmodule PeekCodeGraphql.Resolvers.CustomerResolver do
  alias PeekCode.Customers

  def list_customers(_, _, _), do: {:ok, Customers.list_customers()}
  def create_customer(_, %{payload: payload}, _), do: Customers.create_customer(payload)
end
