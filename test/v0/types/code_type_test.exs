alias CanvasNative.V0.CodeType

defmodule CanvasNative.V0.CodeTypeTest do
  use ExUnit.Case, async: true

  import CodeType
  import CanvasNative.V0.Brackets

  doctest CodeType

  test ".as_json formats the line as JSON" do
    line = "defmodule Foo do" |> match_markdown(%{in_code: "elixir"})
    assert as_json(line) == %{
      type: "code",
      text: "defmodule Foo do",
      meta: %{language: "elixir"}}
  end

  describe ".match_markdown" do
    test "matches Markdown code into a struct when in a code block" do
      source = "#{wrap(type_name <> "-ruby")}class Foo"
      markdown = "class Foo"
      assert markdown |> match_markdown(%{in_code: "ruby"}) ==
        %CodeType{content: "class Foo", source: source, type: type_name,
                  language: "ruby"}
    end

    test "matches Markdown code into a struct when in a code block with no lang" do
      source = "#{wrap(type_name)}class Foo"
      markdown = "class Foo"
      assert markdown |> match_markdown(%{in_code: nil}) ==
        %CodeType{content: "class Foo", source: source, type: type_name,
                  language: nil}
    end
  end

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
                  language: nil}
    end
  end
end
