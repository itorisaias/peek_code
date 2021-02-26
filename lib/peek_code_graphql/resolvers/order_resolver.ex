defmodule PeekCodeGraphql.Resolvers.OrderResolver do
  alias PeekCode.Order
  alias PeekCode.Repo

  def list_orders(_, _, _) do
    {:ok, Repo.all(Order)}
  end

  def create_order(_, %{payload: payload}, _) do
    %Order{}
    |> Order.changeset(payload)
    |> Repo.insert()
  end
end
