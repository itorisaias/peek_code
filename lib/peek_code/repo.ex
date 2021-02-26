defmodule PeekCode.Repo do
  use Ecto.Repo,
    otp_app: :peek_code,
    adapter: Ecto.Adapters.Postgres
end
