defmodule PeekCode.Orders do
  alias PeekCode.Orders.Order
  alias PeekCode.Repo

  def list_orders, do: Repo.all(Order)

  def create_order(payload) do
    payload
    |> process_payment()
    |> case do
      {:error, msg} ->
        {:error, msg}

      {:ok, balance_due} ->
        payload = Map.put(payload, :balance_due, balance_due)

        %Order{}
        |> Order.changeset(payload)
        |> Repo.insert()
    end
  end

  defp process_payment(order) do
    order
    |> Map.has_key?(:payments)
    |> case do
      true ->
        payments_duplicated =
          order.payments
          |> Enum.group_by(& &1)
          |> Enum.filter(fn
            {_, [_, _ | _]} -> true
            _ -> false
          end)
          |> Enum.map(fn {x, _} -> x end)
          |> Enum.count()

        get_balance_due(payments_duplicated > 0, order)

      false ->
        order.total
    end
  end

  defp get_balance_due(true, _) do
    {:error, "Payment duplicated"}
  end

  defp get_balance_due(false, order) do
    {:ok, order.total - (order.payments |> Enum.map(& &1.amount) |> Enum.sum())}
  end
end
