alias CanvasNative.V0.{MarkdownParser, BlockquoteType, ChecklistType, CodeType,
                       HeadingType, HorizontalRuleType, ImageType,
                       LinkDefinitionType, OrderedListType, ParagraphType,
                       TitleType, UnorderedListType}

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

    ```elixir
    defmodule Foo do
      def bar do



      end
    end
    ```

    ```
    no language
    ```

    > Foo
    > Bar

    - - -

    - [ ] Foo
    - [x] Bar
    - [X] Baz

    ![image](https://example.com/foo.png)
    https://example.com/foo.png

    [example]: https://example.com

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
       %CodeType{content: "defmodule Foo do", language: "elixir"},
       %CodeType{content: "  def bar do", language: "elixir"},
       %CodeType{content: "", language: "elixir"},
       %CodeType{content: "", language: "elixir"},
       %CodeType{content: "", language: "elixir"},
       %CodeType{content: "  end", language: "elixir"},
       %CodeType{content: "end", language: "elixir"},
       %CodeType{content: "no language", language: nil},
       %BlockquoteType{content: "Foo"},
       %BlockquoteType{content: "Bar"},
       %HorizontalRuleType{content: "- - -"},
       %ChecklistType{content: "Foo", checked: false},
       %ChecklistType{content: "Bar", checked: true},
       %ChecklistType{content: "Baz", checked: true},
       %ImageType{url: "https://example.com/foo.png"},
       %ImageType{url: "https://example.com/foo.png"},
       %LinkDefinitionType{label: "example", url: "https://example.com"},
       %ParagraphType{content: "Paragraph"},
       %ParagraphType{content: "Paragraph"},
       %ParagraphType{content: ""},
       %ParagraphType{content: "Paragraph"}],
      result)
  end
end
