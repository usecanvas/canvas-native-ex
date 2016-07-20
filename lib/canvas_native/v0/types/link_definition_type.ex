alias CanvasNative.Type

defmodule CanvasNative.V0.LinkDefinitionType do
  @moduledoc """
  A link definition in a v0 canvas native document.

      iex> source = "[example]: https://example.com"
      iex> match_native(source)
      %LinkDefinitionType{source: "[example]: https://example.com",
                          content: "[example]: https://example.com",
                          label: "example", url: "https://example.com",
                          type: type_name}
  """

  defstruct content: "", source: "", type: "", label: "", url: ""

  @type t :: %__MODULE__{content: String.t, source: String.t, label: String.t,
                         url: String.t}
  @type_name "link-definition"
  @native_pattern ~r/^(?<content>\[(?<label>\S+)\]: (?<url>.+))$/i
  @markdown_pattern @native_pattern

  use Type
end
