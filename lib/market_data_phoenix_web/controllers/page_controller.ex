defmodule MarketDataPhoenixWeb.PageController do
  use MarketDataPhoenixWeb, :controller

  def home(conn, _params) do
    path = "priv/static/data/data.txt" |> Path.expand()
    maps = MarketDataPhoenix.main(path, "changePercent")
    render(conn, :home, data: maps)
  end
end
