alias CanvasNative.V0.Parser

defmodule CanvasNative.V0.MarkdownParser do
  @moduledoc """
  A parser for Markdown text into canvas native structs.

      iex> MarkdownParser.parse("Foo")
      [%ParagraphType{content: "Foo", source: "Foo", type: "paragraph"}]
  """

  @behaviour Parser

  @doc """
  Parse a Markdown string into a list of canvas native lines.
  """
  @spec parse(String.t) :: list(map)
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Stream.map(&parse_line/1)
    |> Enum.to_list
  end

  # Parse a single markdown line into a map.
  @spec parse_line(String.t) :: map
  defp parse_line(line) do
    Parser.parse_order
    |> Enum.reduce_while(nil, try_match(line))
  end

  # Return a function that tries to match against a type module for `line`.
  @spec try_match(String.t) :: ((module, nil) -> {:halt, map} | {:cont, nil})
  defp try_match(line) do
    fn (type, nil) ->
      case type.match_markdown(line) do
        result when not is_nil(result) -> {:halt, result}
        nil -> {:cont, nil}
      end
    end
  end
end
