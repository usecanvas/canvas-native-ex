alias CanvasNative.Type

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

  use Type
end
