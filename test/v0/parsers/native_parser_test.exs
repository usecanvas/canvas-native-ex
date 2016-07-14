alias CanvasNative.V0.{NativeParser, ParagraphType}

defmodule CanvasNative.V0.NativeParserTest do
  use ExUnit.Case
  doctest NativeParser

  import NativeParser


  test "parses a string of v0 into a map of v0 lines" do
    result = parse("Foo\nBar")
    assert match?(
      [%ParagraphType{content: "Foo"}, %ParagraphType{content: "Bar"}], result)
  end
end
