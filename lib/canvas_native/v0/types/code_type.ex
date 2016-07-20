alias CanvasNative.Type

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
  @native_pattern Regex.compile! """
  ^#{wrap(@type_name <> "(?:-(?<language>[^#{close}]*))?")} # Prefix
  (?<content>.*)$
  """, "ix"

  use Type
end
