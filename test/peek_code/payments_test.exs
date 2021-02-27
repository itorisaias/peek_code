defmodule PeekCode.PaymentsTest do
  use PeekCode.DataCase

  alias PeekCode.Orders
  alias PeekCode.Orders.Order
  alias PeekCode.Payments
  alias PeekCode.Repo

  test "apply_payment/1 throw an error because order does not exist" do
    assert {:error, "order does not exist"} ==
             Payments.apply_payment(%{order_id: "9f80eb9f-dd48-4a28-9e4a-5ad80e27f0cb"})
  end

  test "apply_payment/1 throw an error because payment is duplicated" do
    date = NaiveDateTime.utc_now()

    {:ok, order} =
      %{
        description: "MacBook",
        total: 100.99,
        payments: [
          %{
            amount: 10.0,
            applied_at: date,
            note: "payment for this month"
          }
        ]
      }
      |> Orders.create_order()

    payload = %{
      amount: 10.0,
      applied_at: date,
      note: "payment for this month",
      order_id: order.id
    }

    assert {:error, "Payment duplicated"} == Payments.apply_payment(payload)
  end

  test "apply_payment/1 should create a payment" do
    date = NaiveDateTime.utc_now()

    {:ok, order} =
      %{
        description: "MacBook",
        total: 100.99,
        payments: [
          %{
            amount: 10.0,
            applied_at: date,
            note: "payment for this month"
          }
        ]
      }
      |> Orders.create_order()

    assert 90.99 == Repo.get(Order, order.id).balance_due

    {:ok, payment} =
      %{
        amount: 11.3,
        applied_at: date,
        note: "payment for this month",
        order_id: order.id
      }
      |> Payments.apply_payment()

    assert 79.69 == Repo.get(Order, order.id).balance_due
    assert 11.3 == payment.amount
  end
end
