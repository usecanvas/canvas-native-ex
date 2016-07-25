alias CanvasNative.V0.UnorderedListType

defmodule CanvasNative.V0.UnorderedListTypeTest do
  use ExUnit.Case, async: true

  import UnorderedListType
  import CanvasNative.V0.Brackets

  doctest UnorderedListType

  test ".as_json formats the line as JSON" do
    line = "  - Foo" |> match_markdown
    assert as_json(line) == %{
      type: "unordered-list-item",
      text: "Foo",
      meta: %{level: 1}}
  end

  test ".match_markdown matches a Markdown ordered list item into a struct" do
    source = "#{wrap(type_name <> "-2")}- Foo"
    md = "   + Foo"
    assert md |> match_markdown ==
      %UnorderedListType{content: "Foo", source: source, type: type_name,
                         level: 2, marker: "-"}
  end

  test ".match_native matches a native unordered list item into a struct" do
    source = "#{wrap(type_name <> "-1")}- Foo"
    assert source |> match_native ==
      %UnorderedListType{content: "Foo", source: source, type: type_name,
                         level: 1, marker: "-"}
  end
end
