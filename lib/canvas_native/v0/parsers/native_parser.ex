defmodule CanvasNative.V0.NativeParser do
  @moduledoc """
  A parser for v0 canvas native text.
  """

  @behaviour CanvasNative.Parser

  @doc """
  Parse a string of v0 canvas native text into a list of canvas native lines.
  """
  @spec parse(String.t) :: list(map)
  def parse(_native) do
    [%{}]
  end
end
