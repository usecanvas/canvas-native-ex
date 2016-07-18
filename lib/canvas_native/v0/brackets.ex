defmodule CanvasNative.V0.Brackets do
  @moduledoc """
  Markers that delimit the "type" of some lines in a canvas native v0 canvas.
  """

  @open "⧙"
  @close "⧘"

  @doc """
  Wrap a string in brackets.
  """
  @spec wrap(String.t) :: String.t
  def wrap(string), do: @open <> string <> @close
end
