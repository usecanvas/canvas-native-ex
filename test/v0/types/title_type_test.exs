alias CanvasNative.V0.TitleType

defmodule CanvasNative.V0.TitleTypeTest do
  use ExUnit.Case, async: true

  import TitleType
  import CanvasNative.V0.Brackets

  doctest TitleType

  test ".as_json returns a proper type and text" do
    line = "# Foo" |> match_markdown(%{has_title: false})
    assert TitleType.as_json(line) == %{type: "title", text: "Foo"}
  end

  describe ".match_markdown" do
    test "matches a Markdown title into a struct with no title in context" do
      source = "#{wrap type_name}Foo"
      md = "# Foo"
      assert md |> match_markdown(%{has_title: false}) ==
        %TitleType{content: "Foo", source: source, type: type_name}
    end

    test "matches a Markdown title into nil with a title in context" do
      md = "# Foo"
      assert md |> match_markdown(%{has_title: true}) == nil
    end
  end

  test ".match_native matches a native title into a struct" do
    source = "#{wrap type_name}Foo"
    assert source |> match_native ==
      %TitleType{content: "Foo", source: source, type: type_name}
  end
end
