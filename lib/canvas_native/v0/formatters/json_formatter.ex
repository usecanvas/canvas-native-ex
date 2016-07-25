defmodule CanvasNative.V0.JSONFormatter do
  @moduledoc """
  Formats a list of CanvasNative lines into a JSON map.

  A JSON map will consist of a key `:type` with the value `"canvas"`, and the
  key `:content`, which is a list of maps for each individual line.

  A JSON map for a single line will consist of at least the keys `:type` and
  `:content`. The key `:type` is a name specifying the type of line this is,
  while `:content` is a string representation of the line content. Note that
  with some lines, content will always be blank.

  Frequently, `:meta` will be included as well to specify things like code
  language.
  """

  @type json_format :: %{type: String.t, content: [map]}

  @doc """
  Format a list of lines as CanvasNative.

      iex> lines = "# Title\\nParagraph" |> parse
      iex> format(lines)
      %{
        type: "canvas",
        content: [%{
          type: "title",
          text: "Title"
        }, %{
          type: "paragraph",
          text: "Paragraph"
        }]
      }
  """
  @spec format([struct]) :: json_format
  def format(lines) do
    %{
      type: "canvas",
      content: Enum.map(lines, &(&1.__struct__.as_json(&1)))
    }
  end
end
