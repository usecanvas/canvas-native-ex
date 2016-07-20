alias CanvasNative.V0.Type

defmodule CanvasNative.V0.ParagraphType do
  @moduledoc """
  A paragraph of text in a v0 canvas native document.

      iex> ParagraphType.match_native("Foo")
      %ParagraphType{content: "Foo", source: "Foo", type: "paragraph"}
  """

  defstruct content: "", source: "", type: ""

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t}
  @native_pattern ~r/^(?<content>.*)$/i
  @markdown_pattern @native_pattern
  @type_name "paragraph"

  use Type
end
