alias CanvasNative.V0.OrderedListType

defmodule CanvasNative.V0.OrderedListTypeTest do
  use ExUnit.Case, async: true

  import OrderedListType
  import CanvasNative.V0.Brackets

  doctest OrderedListType

  test ".match_native matches a native ordered list item into a struct" do
    source = "#{wrap(type_name <> "-1")}4. Foo"
    assert source |> match_native ==
      %OrderedListType{content: "Foo", source: source, type: type_name, level: 1,
                     number: 4}
  end
end
