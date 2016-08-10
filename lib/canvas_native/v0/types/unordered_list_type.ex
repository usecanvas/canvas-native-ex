alias CanvasNative.V0.ListType

defmodule CanvasNative.V0.UnorderedListType do
  @moduledoc """
  An item in an ordered list in a v0 canvas native document.

      iex> source = wrap(type_name <> "-1") <> "* ULLI"
      iex> UnorderedListType.match_native(source)
      %UnorderedListType{content: "ULLI",
                      source: wrap("unordered-list-1") <> "* ULLI",
                      type: type_name, level: 1, marker: "*"}
  """

  defstruct content: "", source: "", type: "", level: 1, marker: "-"

  import CanvasNative.V0.Brackets

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t,
                         level: pos_integer, marker: String.t}
  @type_name "unordered-list"

  @markdown_pattern Regex.compile! """
  ^\\ *(?<marker>[\\*\\-\\+]) # Marker
  \\ (?<content>.*)$          # Content
  """, "ix"

  @native_pattern Regex.compile! """
  ^#{wrap(@type_name <> "-(?<level>\\d+)")} # Prefix
  \\ *(?<marker>[\\*\\-\\+])                # Marker
  \\ (?<content>.*)$                        # Content
  """, "ix"

  use ListType

  def match_markdown(md, ctx) do
    if Regex.match?(@markdown_pattern, md) do
      md = ~r/^( *)[\+\*]/ |> Regex.replace(md, "\\g{1}-") # Convert marker to -

      ~r/^ */
      |> Regex.replace(md, prefix(md, ctx))
      |> match_native
    end
  end

  defp after_match_native(map) do
    map
    |> Map.delete("level")
    |> Map.put(:level, map["level"] |> String.to_integer(10))
  end
end
