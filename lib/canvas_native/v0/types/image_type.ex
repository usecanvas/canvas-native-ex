alias CanvasNative.Type

defmodule CanvasNative.V0.ImageType do
  @moduledoc """
  An image in a v0 canvas native document.
  """

  defstruct content: "", source: "", type: "", url: "", metadata: %{}

  import CanvasNative.V0.Brackets

  @type t :: %__MODULE__{content: String.t, source: String.t, type: String.t,
                         url: String.t, metadata: %{String.t => String.t}}
  @type_name "image"
  @native_pattern Regex.compile! """
  ^#{wrap(@type_name <> "(?:-(?<metadata>.*?))?")} # Prefix
  (?<url>.*)$                                      # URL
  """, "ix"

  use Type

  defp after_match_native(map) do
    metadata = get_metadata(map["metadata"])
    url = get_url(map["url"], metadata)

    map
    |> Map.put_new(:url, url)
    |> Map.put_new(:content, map["url"])
    |> Map.put_new(:metadata, metadata)
    |> Map.delete("metadata")
    |> Map.delete("url")
  end

  defp get_url(_, %{"url" => url}), do: url
  defp get_url(url, _), do: url

  defp get_metadata(""), do: %{}
  defp get_metadata(binary) do
    case Poison.decode(binary) do
      {:ok, map} -> map
      _ -> %{}
    end
  end
end
