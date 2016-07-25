alias CanvasNative.V0.LinkDefinitionType

defmodule CanvasNative.V0.LinkDefinitionTypeTest do
  use ExUnit.Case, async: true

  import LinkDefinitionType
  doctest LinkDefinitionType

  test ".as_json formats the line as JSON" do
    label = "example"
    url = "https://example.com"
    line = "[#{label}]: #{url}" |> match_markdown
    assert as_json(line) == %{
      type: "link-definition",
      text: "",
      meta: %{label: label, url: url}}
  end

  test ".match_markdown matches a Markdown link definition into a struct" do
    md = "[example]: https://example.com"
    assert md |> match_markdown ==
      %LinkDefinitionType{content: md, source: md, type: type_name,
                          url: "https://example.com", label: "example"}
  end

  test ".match_native matches a native link definition into a struct" do
    source = "[example]: https://example.com"
    assert source |> match_native ==
      %LinkDefinitionType{content: source, source: source, type: type_name,
                          url: "https://example.com", label: "example"}
  end
end
