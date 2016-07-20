alias CanvasNative.V0.LinkDefinitionType

defmodule CanvasNative.V0.LinkDefinitionTypeTest do
  use ExUnit.Case, async: true

  import LinkDefinitionType
  doctest LinkDefinitionType

  test ".match_native matches a native link definition into a struct" do
    source = "[example]: https://example.com"
    assert source |> match_native ==
      %LinkDefinitionType{content: source, source: source, type: type_name,
                          url: "https://example.com", label: "example"}
  end
end
