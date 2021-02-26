defmodule PeekCodeGraphql.Schema.Types.PaymentType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: PeekCode.Repo

  object :payment_type do
    field :amount, :float
    field :applied_at, :string
    field :note, :string
  end

end
