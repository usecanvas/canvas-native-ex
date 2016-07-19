alias CanvasNative.V0.ChecklistType

defmodule CanvasNative.V0.ChecklistTypeTest do
  use ExUnit.Case, async: true

  import ChecklistType
  import CanvasNative.V0.Brackets

  doctest ChecklistType

  test ".match_native matches a native blockquote into a struct" do
    source = "#{wrap(type_name <> "-1")}- [x] Foo"
    assert source |> match_native ==
      %ChecklistType{content: "Foo", source: source, type: type_name, level: 1,
                     checked: true}
  end
end
