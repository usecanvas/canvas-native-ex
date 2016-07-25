alias CanvasNative.V0.ParagraphType

defmodule CanvasNative.V0.ParagraphTypeTest do
  use ExUnit.Case, async: true
  doctest ParagraphType

  import ParagraphType

  test ".as_json formats the line as JSON" do
    line = "Foo" |> match_markdown
    assert as_json(line) == %{
      type: "paragraph",
      text: "Foo"}
  end

  test ".match_markdown matches a markdown paragraph into a struct" do
    result = match_markdown("Foo")
    assert result ==
      %ParagraphType{content: "Foo", source: "Foo", type: "paragraph"}
  end

  test ".match_native matches a native paragraph into a struct" do
    result = match_native("Foo")
    assert result ==
      %ParagraphType{content: "Foo", source: "Foo", type: "paragraph"}
  end
end
