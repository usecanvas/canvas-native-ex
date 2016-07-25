alias CanvasNative.V0.BlockquoteType

defmodule CanvasNative.V0.BlockquoteTypeTest do
  use ExUnit.Case, async: true

  import BlockquoteType
  import CanvasNative.V0.Brackets

  doctest BlockquoteType

  test ".as_json formats the struct as JSON" do
    line = "> Foo" |> match_markdown
    assert as_json(line) == %{type: "blockquote-item", text: "Foo"}
  end

  test ".match_markdown matches a Markdown blockquote into a struct" do
    md = "> Foo"
    source = "#{wrap type_name}#{md}"
    assert md |> match_markdown ==
      %BlockquoteType{content: "Foo", source: source, type: type_name}
  end

  test ".match_native matches a native blockquote into a struct" do
    source = "#{wrap type_name}> Foo"
    assert source |> match_native ==
      %BlockquoteType{content: "Foo", source: source, type: type_name}
  end
end
