alias CanvasNative.V0.ChecklistType

defmodule CanvasNative.V0.ChecklistTypeTest do
  use ExUnit.Case, async: true

  import ChecklistType
  import CanvasNative.V0.Brackets

  doctest ChecklistType

  test ".as_json formats the line as JSON" do
    line = "  - [x] Foo" |> match_markdown
    assert as_json(line) == %{
      type: "checklist",
      text: "Foo",
      meta: %{level: 1, checked: true}}
  end

  test ".match_markdown matches a Markdown checklist into a struct" do
    md = "    + [x] Foo"
    source = "#{wrap(type_name <> "-2")}- [x] Foo"
    assert md |> match_markdown ==
      %ChecklistType{content: "Foo", source: source, type: type_name, level: 2,
                     checked: true}
  end

  test ".match_native matches a native checklist item into a struct" do
    source = "#{wrap(type_name <> "-1")}- [x] Foo"
    assert source |> match_native ==
      %ChecklistType{content: "Foo", source: source, type: type_name, level: 1,
                     checked: true}
  end
end
