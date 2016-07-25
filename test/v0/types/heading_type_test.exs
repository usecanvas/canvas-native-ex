alias CanvasNative.V0.HeadingType

defmodule CanvasNative.V0.HeadingTypeTest do
  use ExUnit.Case, async: true
  doctest HeadingType

  import HeadingType

  test ".as_json includes the type, text, and meta" do
    line = match_markdown("### Foo")
    assert as_json(line) == %{type: "heading", text: "Foo", meta: %{level: 3}}
  end

  test ".match_markdown matches a Markdown heading into a struct" do
    result = match_markdown("## Foo")
    assert result ==
      %HeadingType{content: "Foo", source: "## Foo", type: "heading", level: 2}
  end

  test ".match_native matches a native heading into a struct" do
    result = match_native("## Foo")
    assert result ==
      %HeadingType{content: "Foo", source: "## Foo", type: "heading", level: 2}
  end
end
