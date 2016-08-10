alias CanvasNative.V0.HorizontalRuleType

defmodule CanvasNative.V0.HorizontalRuleTypeTest do
  use ExUnit.Case, async: true

  import HorizontalRuleType
  import CanvasNative.V0.Brackets

  doctest HorizontalRuleType

  test ".as_json formats the line as JSON" do
    line = "- - - -" |> match_markdown
    assert as_json(line) == %{type: "horizontal-rule", text: ""}
  end

  test ".match_markdown matches a Markdown horizontal rule into a struct" do
    source = wrap type_name
    assert "- - -" |> match_markdown ==
      %HorizontalRuleType{content: "- - -", source: source, type: type_name}
  end

  test ".match_native matches a native horizontal rule into a struct" do
    source = wrap type_name
    assert source |> match_native ==
      %HorizontalRuleType{content: "- - -", source: source, type: type_name}
  end
end
