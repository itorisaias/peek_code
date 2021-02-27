defmodule PeekCodeGraphql.Resolvers.PaymentResolver do
  alias PeekCode.Payments
  def apply_payment(_, %{payload: payload}, _), do: Payments.apply_payment(payload)
end
