alias CanvasNative.V0.ParagraphType

defmodule CanvasNative.V0.ParagraphTypeTest do
  use ExUnit.Case, async: true
  doctest ParagraphType

  import ParagraphType

  test ".match_native matches a native paragraph into a struct" do
    result = match_native("Foo")
    assert result ==
      %ParagraphType{content: "Foo", source: "Foo", type: "paragraph"}
  end
end
