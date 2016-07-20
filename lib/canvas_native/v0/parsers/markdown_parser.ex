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
    context = %{
      has_title: false, in_code: false, last_line_blank: false
    }

    markdown
    |> String.split("\n")
    |> Enum.reduce({[], context}, &parse_line/2)
    |> elem(0)
    |> Enum.reverse
  end

  # Parse a single markdown line into a map.
  @spec parse_line(String.t, {[map], map}) :: {[map], map}
  defp parse_line("",
                  {result, ctx = %{in_code: false, last_line_blank: false}}) do
    {result, %{ctx|last_line_blank: true, has_title: true}}
  end

  defp parse_line(markdown, {result, ctx}) do
    line =
      Parser.parse_order
      |> Enum.reduce_while(nil,
                           Parser.try_match([markdown, ctx], :match_markdown))

    {[line|result], %{ctx|last_line_blank: markdown == "", has_title: true}}
  end
end
