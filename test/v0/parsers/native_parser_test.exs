alias CanvasNative.V0.{NativeParser, BlockquoteType, ChecklistType, CodeType,
                       HeadingType, HorizontalRuleType, ImageType,
                       LinkDefinitionType, OrderedListType, ParagraphType,
                       TitleType, UnorderedListType}

defmodule CanvasNative.V0.NativeParserTest do
  use ExUnit.Case, async: true
  doctest NativeParser

  import NativeParser
  import CanvasNative.V0.Brackets

  test "parses a string of v0 into a map of v0 lines" do
    result = parse """
    #{wrap "doc-heading"}Title
    [example]: https://example.com
    #{wrap "image"}https://example.com/foo.png
    #{wrap "horizontal-rule"}
    #{wrap "code-ruby"}class Foo
    #{wrap "checklist-2"}    - [x] Checklist
    #{wrap "ordered-list-2"}2. Foo
    #{wrap "unordered-list-3"}+ Foo
    #{wrap "blockquote-item"}> Blockquote
    # Heading
    Paragraph\
    """

    assert match?(
      [%TitleType{content: "Title"},
       %LinkDefinitionType{content: "[example]: https://example.com"},
       %ImageType{content: "https://example.com/foo.png"},
       %HorizontalRuleType{content: "- - -"},
       %CodeType{content: "class Foo"},
       %ChecklistType{content: "Checklist"},
       %OrderedListType{content: "Foo"},
       %UnorderedListType{content: "Foo"},
       %BlockquoteType{content: "Blockquote"},
       %HeadingType{content: "Heading"},
       %ParagraphType{content: "Paragraph"}],
      result)
  end
end
