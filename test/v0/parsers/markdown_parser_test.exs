alias CanvasNative.V0.{MarkdownParser, ParagraphType}

defmodule CanvasNative.V0.MarkdownParserTest do
  use ExUnit.Case
  doctest MarkdownParser

  import MarkdownParser

  test "parses a string of v0 into a map of v0 lines" do
    result = parse """
    Paragraph\
    """

    assert match?(
      [%ParagraphType{content: "Paragraph"}],
      result)
  end
end
