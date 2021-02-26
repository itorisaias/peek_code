alias PeekCode.{Order, Payment, Repo}

Order.changeset(%Order{}, %{
  description: "MacBook",
  total: 100.99,
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
  total: 100.99
})
|> Repo.insert!()

Order.changeset(%Order{}, %{
  description: "MacBook",
  total: 100.99,
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
