alias CanvasNative.V0.{NativeParser, BlockquoteType, ChecklistType, CodeType,
                       HeadingType, HorizontalRuleType, ParagraphType}

defmodule CanvasNative.V0.NativeParserTest do
  use ExUnit.Case
  doctest NativeParser

  import NativeParser
  import CanvasNative.V0.Brackets

  test "parses a string of v0 into a map of v0 lines" do
    result = parse """
    - - -
    #{wrap "code-ruby"}class Foo
    #{wrap "checklist-item-2"}    - [x] Checklist
    #{wrap "blockquote-item"}> Blockquote
    # Heading
    Paragraph\
    """

    assert match?(
      [%HorizontalRuleType{content: "- - -"},
       %CodeType{content: "class Foo"},
       %ChecklistType{content: "Checklist"},
       %BlockquoteType{content: "Blockquote"},
       %HeadingType{content: "Heading"},
       %ParagraphType{content: "Paragraph"}],
      result)
  end
end
