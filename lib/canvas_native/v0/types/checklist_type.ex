alias CanvasNative.Type

defmodule CanvasNative.V0.ChecklistType do
  @moduledoc """
  A checklist item in a v0 canvas native document.

      iex> source = wrap(type_name <> "-1") <> "- [ ] Checklist"
      iex> ChecklistType.match_native(source)
      %ChecklistType{content: "Checklist",
                      source: wrap("checklist-item-1") <> "- [ ] Checklist",
                      type: type_name, checked: false, level: 1}
  """

  defstruct content: "", source: "", type: "", level: 1, checked: false

  import CanvasNative.V0.Brackets

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t,
                         level: pos_integer, checked: boolean}
  @type_name "checklist-item"
  @native_pattern Regex.compile! """
  ^#{wrap("checklist-item" <> "-(?<level>\\d+)")} # Prefix
  \\ *[\\-\\+\\*]\\ \\[(?<check>[x\\ ])\\]        # Checkmark
  \\ (?<content>.*)$                              # Content
  """, "ix"

  use Type

  defp after_match_native(map) do
    map
    |> Map.delete("check")
    |> Map.delete("level")
    |> Map.put(:level, map["level"] |> String.to_integer(10))
    |> Map.put(:checked, map["check"] != " ")
  end
end
