alias CanvasNative.V0.Type

defmodule CanvasNative.V0.HorizontalRuleType do
  @moduledoc """
  A horizontal rule in a canvas native v0 document.

      iex> HorizontalRuleType.match_markdown("- - -")
      %HorizontalRuleType{content: "- - -", source: wrap("horizontal-rule"),
                          type: "horizontal-rule"}
  """

  defstruct content: "- - -", source: "", type: ""

  import CanvasNative.V0.Brackets

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t}
  @type_name "horizontal-rule"
  @native_pattern Regex.compile! "^#{wrap @type_name}$"
  @markdown_pattern ~r/^(?<content>(?:- ?){3,})$/

  use Type, has_prefix: true

  def as_json(struct) do
    %{type: @type_name, text: ""}
  end

  def match_markdown(markdown, ctx) do
    if Regex.match?(@markdown_pattern, markdown) do
      "#{prefix markdown, ctx}"
      |> match_native
      |> Map.put(:content, markdown)
    end
  end
end
