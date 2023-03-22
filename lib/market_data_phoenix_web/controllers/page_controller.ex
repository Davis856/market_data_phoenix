defmodule MarketDataPhoenixWeb.PageController do
  use MarketDataPhoenixWeb, :controller
  @path Application.compile_env(:market_data_phoenix, :data_file_path)

  def home(conn, _params) do
    maps = MarketDataPhoenix.main(@path, "changePercent")
    render(conn, :home, data: maps)
  end
end
