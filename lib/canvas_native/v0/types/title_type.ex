alias CanvasNative.Type

defmodule CanvasNative.V0.TitleType do
  @moduledoc """
  The title of a v0 canvas native document.

      iex> source = wrap(type_name) <> "Title"
      iex> TitleType.match_native(source)
      %TitleType{content: "Title", source: wrap("doc-heading") <> "Title",
                 type: type_name}
  """

  defstruct content: "", source: "", type: ""

  import CanvasNative.V0.Brackets

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t}
  @type_name "doc-heading"
  @markdown_pattern ~r/^# (?<content>.*)$/i
  @native_pattern Regex.compile! "^#{wrap @type_name}(?<content>.*)$", "i"

  use Type
end
