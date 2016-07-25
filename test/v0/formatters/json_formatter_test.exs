alias CanvasNative.V0.{JSONFormatter, MarkdownParser}

defmodule CanvasNative.V0.JSONFormatterTest do
  use ExUnit.Case, async: true

  import JSONFormatter
  import MarkdownParser

  test ".format formats lines as JSON" do
    source = parse """
    # Title

    ## Heading

    - ULLI
      - ULLI

    1. OLLI

    ```elixir
    IO.inspect "foo"
    ```

    ```
    no language
    ```

    > Foo

    - - -

    - [ ] Foo
      - [x] Bar

    ![image](https://example.com/foo.png)

    [example]: https://example.com

    Paragraph\
    """

    json = format source

    assert json == %{
      type: "canvas",
      content: [%{
        type: "title",
        text: "Title"
      }, %{
        type: "heading",
        text: "Heading",
        meta: %{level: 2}
      }, %{
        type: "unordered-list-item",
        text: "ULLI",
        meta: %{level: 0}
      }, %{
        type: "unordered-list-item",
        text: "ULLI",
        meta: %{level: 1}
      }, %{
        type: "ordered-list-item",
        text: "OLLI",
        meta: %{level: 0}
      }, %{
        type: "code",
        text: "IO.inspect \"foo\"",
        meta: %{language: "elixir"}
      }, %{
        type: "code",
        text: "no language",
        meta: %{language: nil}
      }, %{
        type: "blockquote-item",
        text: "Foo"
      }, %{
        type: "horizontal-rule",
        text: ""
      }, %{
        type: "checklist-item",
        text: "Foo",
        meta: %{level: 0, checked: false}
      }, %{
        type: "checklist-item",
        text: "Bar",
        meta: %{level: 1, checked: true}
      }, %{
        type: "image",
        text: "",
        meta: %{url: "https://example.com/foo.png"}
      }, %{
        type: "link-definition",
        text: "",
        meta: %{label: "example", url: "https://example.com"}
      }, %{
        type: "paragraph",
        text: "Paragraph"
      }]
    }
  end
end
