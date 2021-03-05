alias PeekCode.Customers.Customer
alias PeekCode.Orders.Order
alias PeekCode.Repo

%Customer{id: customer_id} =
  Customer.changeset(%Customer{}, %{
    email: "maria.silva@exemplo.com",
    first_name: "Maria",
    last_name: "Silva"
  })
  |> Repo.insert!()

Order.changeset(%Order{}, %{
  description: "MacBook",
  total: 100.99,
  customer_id: customer_id,
  payments: [
    %{
      amount: 10.0,
      applied_at: NaiveDateTime.utc_now(),
      note: "payment for this month"
    }
  ]
})
|> Repo.insert!()

Order.changeset(%Order{}, %{
  description: "MacBook",
  total: 100.99,
  customer_id: customer_id
})
|> Repo.insert!()

Order.changeset(%Order{}, %{
  description: "MacBook",
  total: 100.99,
  customer_id: customer_id,
  payments: [
    %{
      amount: 10.0,
      applied_at: NaiveDateTime.utc_now(),
      note: "payment for this month"
    },
    %{
      amount: 22.0,
      applied_at: NaiveDateTime.utc_now(),
      note: "payment for this month"
    }
  ]
})
|> Repo.insert!()
