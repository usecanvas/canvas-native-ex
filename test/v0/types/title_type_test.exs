alias CanvasNative.V0.TitleType

defmodule CanvasNative.V0.TitleTypeTest do
  use ExUnit.Case, async: true

  import TitleType
  import CanvasNative.V0.Brackets

  doctest TitleType

  test ".match_native matches a native title into a struct" do
    source = "#{wrap type_name}Foo"
    assert source |> match_native ==
      %TitleType{content: "Foo", source: source, type: type_name}
  end
end
