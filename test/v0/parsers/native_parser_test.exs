alias CanvasNative.V0.{NativeParser, BlockquoteType, HeadingType, ParagraphType}

defmodule CanvasNative.V0.NativeParserTest do
  use ExUnit.Case
  doctest NativeParser

  import NativeParser
  import CanvasNative.V0.Brackets

  test "parses a string of v0 into a map of v0 lines" do
    result = parse """
    #{wrap "blockquote-item"}> Blockquote
    # Heading
    Paragraph\
    """

    assert match?(
      [%BlockquoteType{content: "Blockquote"},
       %HeadingType{content: "Heading"},
       %ParagraphType{content: "Paragraph"}],
      result)
  end
end
