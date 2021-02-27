defmodule PeekCode.Customers do
  alias PeekCode.Customers.Customer
  alias PeekCode.Repo

  def list_customers, do: Repo.all(Customer)

  def create_customer(payload) do
    %Customer{}
    |> Customer.changeset(payload)
    |> Repo.insert()
  end
end
