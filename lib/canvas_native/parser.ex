defmodule CanvasNative.Parser do
  @moduledoc """
  Parses a string into a list of maps representing parsed lines.
  """

  @callback parse(String.t) :: list(map)
end
