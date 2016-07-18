alias CanvasNative.V0.BlockquoteType

defmodule CanvasNative.V0.BlockquoteTypeTest do
  use ExUnit.Case, async: true

  import BlockquoteType
  import CanvasNative.V0.Brackets

  doctest BlockquoteType

  test ".match_native matches a native blockquote into a struct" do
    source = "#{wrap type_name}> Foo"
    assert source |> match_native ==
      %BlockquoteType{content: "Foo", source: source, type: type_name}
  end
end
