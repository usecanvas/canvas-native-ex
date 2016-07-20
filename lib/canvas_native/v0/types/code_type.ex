alias CanvasNative.V0.Type

defmodule CanvasNative.V0.CodeType do
  @moduledoc """
  A code line in a v0 canvas native document.

  iex> source = wrap(type_name <> "-ruby") <> "class Foo"
  iex> CodeType.match_native(source)
  %CodeType{content: "class Foo",
            source: wrap(type_name <> "-ruby") <> "class Foo",
            type: type_name, language: "ruby"}
  """

  defstruct content: "", source: "", type: "", language: ""

  import CanvasNative.V0.Brackets

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t,
                         language: String.t}
  @type_name "code"
  @markdown_pattern ~r/^(?<content>.*)$/i
  @native_pattern Regex.compile! """
  ^#{wrap(@type_name <> "(?:-(?<language>[^#{close}]*))?")} # Prefix
  (?<content>.*)$
  """, "ix"

  use Type, has_prefix: true

  def match_markdown(md, ctx) do
    if ctx[:in_code] != false do
      super(md, ctx)
    end
  end

  def after_match_native(map) do
    map
    |> Map.delete("language")
    |> Map.put(:language, get_language(map["language"]))
  end

  # Get the language
  @spec get_language(String.t) :: String.t | nil
  defp get_language(""), do: nil
  defp get_language(lang), do: lang

  defp prefix(_, %{in_code: nil}), do: wrap(@type_name)
  defp prefix(_, %{in_code: lang}) when is_binary(lang) do
    wrap(@type_name <> "-#{lang}")
  end
end
