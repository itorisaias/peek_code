defmodule PeekCode.Payments do
  alias Ecto.Multi
  alias PeekCode.Orders.Order
  alias PeekCode.Payment.Payment
  alias PeekCode.Repo

  def apply_payment(payload) do
    Order
    |> Repo.get(payload.order_id)
    |> build_response(payload)
  end

  defp build_response(nil, _), do: {:error, "this order does not exist"}

  defp build_response(order, payload) do
    {:ok, %{payment: payment}} =
      Multi.new()
      |> Multi.update(:order, Order.update_balance_due(order, %{amount: payload.amount}))
      |> Multi.insert(:payment, Payment.changeset(%Payment{}, payload))
      |> Repo.transaction()

    {:ok, payment}
  end
end
