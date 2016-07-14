defmodule CanvasNative.Type do
  @moduledoc """
  Describes a type of line in a canvas.
  """

  # Re-add in Elixir 1.3.2
  # @callback match_native(String.t) :: struct | nil

  defmacro __using__(_opts) do
    quote do
      # See above, re-add in 1.3.2
      # @behaviour CanvasNative.Type

      use Constructor

      @doc """
      Match a native string against `@native_pattern`, returning the named
      captures.
      """
      @spec match_native(String.t) :: t | nil
      def match_native(native) do
        case @native_pattern |> Regex.named_captures(native) do
          result when is_map(result) ->
            result
            |> Map.put(:source, native)
            |> Map.put(:type, @type_name)
            |> new
          nil ->
            nil
        end
      end

      defoverridable(match_native: 1)
    end
  end
end
