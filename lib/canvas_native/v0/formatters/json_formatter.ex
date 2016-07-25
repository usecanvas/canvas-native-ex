defmodule CanvasNative.V0.JSONFormatter do
  @moduledoc """
  Formats a list of CanvasNative lines into a JSON map.
  """

  @type json_format :: %{type: String.t, content: [map]}

  @spec format([struct]) :: json_format
  def format(lines) do
    %{
      type: "canvas",
      content: Enum.map(lines, &(&1.__struct__.as_json(&1)))
    }
  end
end
