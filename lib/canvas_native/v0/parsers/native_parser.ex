alias CanvasNative.V0.Parser

defmodule CanvasNative.V0.NativeParser do
  @moduledoc """
  A parser for v0 canvas native text.

      iex> NativeParser.parse("Foo")
      [%ParagraphType{content: "Foo", source: "Foo", type: "paragraph"}]
  """

  @behaviour Parser

  @doc """
  Parse a string of v0 canvas native text into a list of canvas native lines.
  """
  @spec parse(String.t) :: list(map)
  def parse(native) do
    native
    |> String.split("\n")
    |> Stream.map(&parse_line/1)
    |> Enum.to_list
  end

  # Parse a single v0 native line into a line map.
  @spec parse_line(String.t) :: map
  defp parse_line(line) do
    Parser.parse_order
    |> Enum.reduce_while(nil, Parser.try_match([line], :match_native))
  end
end
