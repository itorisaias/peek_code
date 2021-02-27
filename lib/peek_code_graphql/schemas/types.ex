defmodule PeekCodeGraphql.Schema.Types do
  use Absinthe.Schema.Notation

  alias PeekCodeGraphql.Schema.Types
  import_types(Types.CustomerType)
  import_types(Types.OrderType)
  import_types(Types.PaymentType)
end
