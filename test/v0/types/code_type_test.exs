alias CanvasNative.V0.CodeType

defmodule CanvasNative.V0.CodeTypeTest do
  use ExUnit.Case, async: true

  import CodeType
  import CanvasNative.V0.Brackets

  doctest CodeType

  describe ".match_native" do
    test "matches a native code line into a struct" do
      source = "#{wrap(type_name <> "-ruby")}class Foo"
      assert source |> match_native ==
        %CodeType{content: "class Foo", source: source, type: type_name,
                  language: "ruby"}
    end

    test "matches a native code line into a struct with no language" do
      source = "#{wrap(type_name)}class Foo"
      assert source |> match_native ==
        %CodeType{content: "class Foo", source: source, type: type_name,
                  language: ""}
    end
  end
end
