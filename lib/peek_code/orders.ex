defmodule PeekCode.Orders do
  alias PeekCode.Orders.Order
  alias PeekCode.Repo

  def list_orders, do: Repo.all(Order)

  def create_order(payload) do
    %Order{}
    |> Order.changeset(payload)
    |> Repo.insert()
  end
end
