defmodule PeekCodeGraphql.Resolvers.PaymentResolver do
  alias PeekCode.Payment
  alias PeekCode.Repo

  def apply_payment(_, %{payload: payload}, _) do
    %Payment{}
    |> Payment.changeset(payload)
    |> Repo.insert()
    |> IO.inspect
  end
end
