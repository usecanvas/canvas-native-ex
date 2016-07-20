alias CanvasNative.V0.Type

defmodule CanvasNative.V0.HeadingType do
  @moduledoc """
  A heading in a v0 canvas native document.

      iex> HeadingType.match_native("## Heading")
      %HeadingType{content: "Heading", source: "## Heading", type: "heading",
                   level: 2}
  """

  defstruct level: 1, content: "", source: "", type: ""

  @type t :: %__MODULE__{level: 1..6, content: String.t, source: String.t,
                         type: String.t}
  @native_pattern ~r/^(?<hashes>\#{1,6}) (?<content>.*)$/i
  @markdown_pattern @native_pattern
  @type_name "heading"

  use Type

  defp after_match_native(map) do
    map
    |> Map.delete("hashes")
    |> Map.put(:level, map["hashes"] |> String.length)
  end
end
