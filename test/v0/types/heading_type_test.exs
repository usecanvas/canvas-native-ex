alias CanvasNative.V0.HeadingType

defmodule CanvasNative.V0.HeadingTypeTest do
  use ExUnit.Case, async: true
  doctest HeadingType

  import HeadingType

  test ".match_native matches a native heading into a struct" do
    result = match_native("## Foo")
    assert result ==
      %HeadingType{content: "Foo", source: "## Foo", type: "heading", level: 2}
  end
end
