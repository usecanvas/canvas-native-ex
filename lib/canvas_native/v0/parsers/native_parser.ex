alias CanvasNative.V0.{BlockquoteType, ChecklistType, CodeType, HeadingType,
                       HorizontalRuleType, ParagraphType}

defmodule CanvasNative.V0.NativeParser do
  @moduledoc """
  A parser for v0 canvas native text.

      iex> NativeParser.parse("Foo")
      [%ParagraphType{content: "Foo", source: "Foo", type: "paragraph"}]
  """

  @behaviour CanvasNative.Parser

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
    [ChecklistType, BlockquoteType, CodeType, HeadingType, HorizontalRuleType,
     ParagraphType]
    |> Enum.reduce_while(nil, try_match(line))
  end

  # Return a function that tries to match against a type module for `line`.
  @spec try_match(String.t) :: ((module, nil) -> {:halt, map} | {:cont, nil})
  defp try_match(line) do
    fn (type, nil) ->
      case type.match_native(line) do
        result when not is_nil(result) -> {:halt, result}
        nil -> {:cont, nil}
      end
    end
  end
end
