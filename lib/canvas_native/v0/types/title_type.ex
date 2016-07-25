alias CanvasNative.V0.Type

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
  @markdown_pattern ~r/^# (?<content>.*)$/
  @native_pattern Regex.compile! "^#{wrap @type_name}(?<content>.*)$", "i"

  use Type, has_prefix: true

  def as_json(struct), do: %{type: "title", text: struct.content}

  def match_markdown(markdown, ctx) do
    if !ctx[:has_title] && Regex.match?(@markdown_pattern, markdown) do
      markdown
      |> String.slice(2..-1)
      |> String.replace_prefix("", prefix(markdown, ctx))
      |> match_native
    end
  end
end
