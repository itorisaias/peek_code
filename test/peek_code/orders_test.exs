defmodule PeekCode.OrdersTest do
  use PeekCode.DataCase

  alias PeekCode.Customers
  alias PeekCode.Orders

  @customer %{
    email: "gustavo@peek.com",
    first_name: "Gustavo",
    last_name: "Oliveira"
  }

  @success %{
    description: "MacBook",
    total: 100.99,
    payments: [
      %{
        amount: 10.0,
        applied_at: NaiveDateTime.utc_now(),
        note: "payment for this month"
      }
    ]
  }

  test "list_orders/0 returns all orders" do
    {:ok, customer} = Customers.create_customer(@customer)

    @success
    |> Map.put(:customer_id, customer.id)
    |> Orders.create_order()

    assert Orders.list_orders() |> Enum.count() == 1
  end

  test "create_order/1 error to create order with the same payment " do
    date = NaiveDateTime.utc_now()

    result =
      %{
        description: "MacBook",
        total: 100.99,
        payments: [
          %{
            amount: 10.0,
            applied_at: date,
            note: "payment for this month"
          },
          %{
            amount: 10.0,
            applied_at: date,
            note: "payment for this month"
          }
        ]
      }
      |> Orders.create_order()

    assert {:error, "Payment duplicated"} == result
  end

  test "create_order/1 should create an order with payment" do
    date = NaiveDateTime.utc_now()
    {:ok, customer} = Customers.create_customer(@customer)

    {:ok, result} =
      %{
        description: "MacBook",
        total: 100.99,
        customer_id: customer.id,
        payments: [
          %{
            amount: 10.0,
            applied_at: date,
            note: "payment for this month"
          }
        ]
      }
      |> Orders.create_order()

    assert 90.99 == result.balance_due
  end

  test "create_order/1 should create an order without payment" do
    {:ok, customer} = Customers.create_customer(@customer)

    {:ok, result} =
      %{
        description: "MacBook",
        total: 100.99,
        customer_id: customer.id
      }
      |> Orders.create_order()

    assert 100.99 == result.balance_due
  end
end
