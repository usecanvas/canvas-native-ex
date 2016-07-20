alias CanvasNative.V0.{MarkdownParser, HeadingType, OrderedListType,
                       ParagraphType, TitleType, UnorderedListType}

defmodule CanvasNative.V0.MarkdownParserTest do
  use ExUnit.Case
  doctest MarkdownParser

  import MarkdownParser

  test "parses a string of v0 into a map of v0 lines" do
    result = parse """
    # Title

    # Heading

    - ULLI
    - ULLI
      - ULLI
    1. OLLI

    Paragraph

    Paragraph


    Paragraph\
    """

    assert match?(
      [%TitleType{content: "Title"},
       %HeadingType{content: "Heading", level: 1},
       %UnorderedListType{content: "ULLI", level: 0},
       %UnorderedListType{content: "ULLI", level: 0},
       %UnorderedListType{content: "ULLI", level: 1},
       %OrderedListType{content: "OLLI", level: 0},
       %ParagraphType{content: "Paragraph"},
       %ParagraphType{content: "Paragraph"},
       %ParagraphType{content: ""},
       %ParagraphType{content: "Paragraph"}],
      result)
  end
end
