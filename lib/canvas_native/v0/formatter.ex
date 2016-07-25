defmodule CanvasNative.V0.Formatter do
  @moduledoc """
  Formats a list of CanvasNative structs into JSON.
  """

  @callback format([struct]) :: term
end
