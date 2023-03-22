defmodule MarketDataPhoenix do
  @moduledoc """
  Documentation for MarketDataPhoenix
  """

  def open_file(path), do: File.stream!(path, [], :line) |> Stream.map(&String.trim/1) |> Stream.map(&String.split(&1, " ", trim: true)) |> Enum.to_list()

  def get_struct_keys([head | _]), do: head

  def get_struct_values([_ | tail]), do: tail

  def create_struct(keys, values), do: Enum.map(values, fn row -> Enum.zip(keys, row) |> Enum.into(%{}) end)

  def cast_types(object), do: MarketDataPhoenix.Parser.parse_object(object) |> Enum.map(fn row -> Map.new(row) end)

  def get_top(object, column) do
    Enum.sort_by(object, fn map ->
      abs(Map.fetch!(map, column))
    end, :desc)
  end

  def main(path, column) do
    object = open_file(path)
    keys = get_struct_keys(object)
    values = get_struct_values(object)
    struct = create_struct(keys, values)
    struct_typed = cast_types(struct)
    top = get_top(struct_typed, column)
    top
  end

end
