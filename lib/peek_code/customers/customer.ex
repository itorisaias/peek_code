defmodule PeekCode.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias PeekCode.Orders.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field :email, :string, unique: true
    field :first_name, :string
    field :last_name, :string

    has_many :orders, Order

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :first_name, :last_name])
    |> validate_required([:email, :first_name, :last_name])
    |> validate_format(:email, ~r/@/, message: "type a valid e-mail")
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
  end
end
