alias CanvasNative.V0.{NativeParser, HeadingType, ParagraphType}

defmodule CanvasNative.V0.NativeParserTest do
  use ExUnit.Case
  doctest NativeParser

  import NativeParser


  test "parses a string of v0 into a map of v0 lines" do
    result = parse("# Heading\nParagraph")
    assert match?(
      [%HeadingType{content: "Heading"},
       %ParagraphType{content: "Paragraph"}],
      result)
  end
end
