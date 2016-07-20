alias CanvasNative.V0.ListType

defmodule CanvasNative.V0.OrderedListType do
  @moduledoc """
  An item in an ordered list in a v0 canvas native document.

      iex> source = wrap(type_name <> "-1") <> "2. OLLI"
      iex> OrderedListType.match_native(source)
      %OrderedListType{content: "OLLI",
                      source: wrap("ordered-list-item-1") <> "2. OLLI",
                      type: type_name, level: 1, number: 2}
  """

  defstruct content: "", source: "", type: "", level: 1, number: 1

  import CanvasNative.V0.Brackets

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t,
                         level: pos_integer, number: integer}
  @type_name "ordered-list-item"

  @markdown_pattern Regex.compile! """
  ^\\ *(?<number>\\d+)\\. # Number
  \\ (?<content>.*)$      # Content
  """, "ix"

  @native_pattern Regex.compile! """
  ^#{wrap(@type_name <> "-(?<level>\\d+)")} # Prefix
  \\ *(?<number>\\d+)\\.                    # Number
  \\ (?<content>.*)$                        # Content
  """, "ix"

  use ListType

  def match_markdown(md, _) do
    if Regex.match?(@markdown_pattern, md) do
      md = ~r/^( *)\d+/ |> Regex.replace(md, "\\g{1}1") # Convert digit(s) to 1

      ~r/^ */
      |> Regex.replace(md, prefix(md))
      |> match_native
    end
  end

  defp after_match_native(map) do
    map
    |> Map.delete("level")
    |> Map.delete("number")
    |> Map.put(:level, map["level"] |> String.to_integer(10))
    |> Map.put(:number, map["number"] |> String.to_integer(10))
  end
end
