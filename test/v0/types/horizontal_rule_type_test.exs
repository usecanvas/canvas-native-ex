alias CanvasNative.V0.HorizontalRuleType

defmodule CanvasNative.V0.HorizontalRuleTypeTest do
  use ExUnit.Case, async: true

  import HorizontalRuleType

  doctest HorizontalRuleType

  test ".match_native matches a native horizontal rule into a struct" do
    assert "- - -" |> match_native ==
      %HorizontalRuleType{content: "- - -", source: "- - -", type: type_name}
  end
end
