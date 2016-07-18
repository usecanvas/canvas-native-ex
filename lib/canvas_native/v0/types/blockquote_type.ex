alias CanvasNative.Type

defmodule CanvasNative.V0.BlockquoteType do
  @moduledoc """
  A blockquote line in a v0 canvas native document.

      iex> source = wrap(type_name) <> "> Blockquote"
      iex> BlockquoteType.match_native(source)
      %BlockquoteType{content: "Blockquote",
                      source: wrap("blockquote-item") <> "> Blockquote",
                      type: type_name}
  """

  defstruct content: "", source: "", type: ""

  import CanvasNative.V0.Brackets

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t}
  @type_name "blockquote-item"
  @native_pattern Regex.compile! "^#{wrap @type_name}> (?<content>.*)$"

  use Type
end
