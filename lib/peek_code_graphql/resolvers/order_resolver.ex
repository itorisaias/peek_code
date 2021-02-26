defmodule PeekCodeGraphql.Resolvers.OrderResolver do
  def list_orders(_, _, _) do
    {:ok, PeekCode.Repo.all(PeekCode.Order)}
  end
end
