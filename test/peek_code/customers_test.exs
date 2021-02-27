defmodule PeekCode.CustomersTest do
  use PeekCode.DataCase

  alias PeekCode.Customers

  @success %{
    email: "gustavo@peek.com",
    first_name: "Gustavo",
    last_name: "Oliveira"
  }

  test "list_customers/0 returns all customers" do
    Customers.create_customer(@success)
    assert Customers.list_customers() |> Enum.count() == 1
  end

  test "create_customer/1 should create an order without payment" do
    {:ok, result} = Customers.create_customer(@success)

    assert "Gustavo" == result.first_name
  end
end
