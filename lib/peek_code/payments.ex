defmodule PeekCode.Payments do
  import Ecto.Query, only: [from: 2]

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
    verify_if_payment_exist(order, payload)
    |> case do
      true ->
        {:error, "Payment duplicated"}

      false ->
        {:ok, %{payment: payment}} =
          Multi.new()
          |> Multi.update(:order, Order.update_balance_due(order, %{amount: payload.amount}))
          |> Multi.insert(:payment, Payment.changeset(%Payment{}, payload))
          |> Repo.transaction()

        {:ok, payment}
    end
  end

  defp verify_if_payment_exist(order, payload) do
    payments =
      from(p in Payment,
        where:
          p.order_id == ^order.id and
            p.amount ==
              ^payload.amount and
            p.applied_at ==
              ^payload.applied_at
      )
      |> Repo.aggregate(:count, :id)

    payments > 0
  end
end
