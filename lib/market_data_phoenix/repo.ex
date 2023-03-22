defmodule MarketDataPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :market_data_phoenix,
    adapter: Ecto.Adapters.Postgres
end
