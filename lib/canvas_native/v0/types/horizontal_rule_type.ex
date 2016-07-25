alias CanvasNative.V0.Type

defmodule CanvasNative.V0.HorizontalRuleType do
  @moduledoc """
  A horizontal rule in a canvas native v0 document.

  iex> HorizontalRuleType.match_native("- - -")
  %HorizontalRuleType{content: "- - -", source: "- - -",
                      type: "horizontal-rule"}
  """

  defstruct content: "", source: "", type: ""

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t}
  @type_name "horizontal-rule"
  @native_pattern ~r/^(?<content>(?:- ?){3,})$/
  @markdown_pattern @native_pattern

  use Type

  def as_json(_struct), do: %{type: @type_name, text: ""}
end
