alias CanvasNative.V0.OrderedListType

defmodule CanvasNative.V0.OrderedListTypeTest do
  use ExUnit.Case, async: true

  import OrderedListType
  import CanvasNative.V0.Brackets

  doctest OrderedListType

  test ".as_json formats the line as JSON" do
    line = "1. Foo" |> match_markdown
    assert as_json(line) == %{
      type: "ordered-list",
      text: "Foo",
      meta: %{level: 0}}
  end

  test ".match_markdown matches a Markdown ordered list item into a struct" do
    source = "#{wrap(type_name <> "-2")}1. Foo"
    md = "   4. Foo"
    assert md |> match_markdown ==
      %OrderedListType{content: "Foo", source: source, type: type_name, level: 2,
                     number: 1}
  end

  test ".match_native matches a native ordered list item into a struct" do
    source = "#{wrap(type_name <> "-1")}4. Foo"
    assert source |> match_native ==
      %OrderedListType{content: "Foo", source: source, type: type_name, level: 1,
                     number: 4}
  end
end
