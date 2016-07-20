defmodule CanvasNative.V0.Type do
  @moduledoc """
  Describes a type of line in a canvas.
  """

  # Re-add in Elixir 1.3.2
  # @callback match_native(String.t) :: struct | nil

  defmacro __using__(_opts) do
    quote do
      # See above, re-add in 1.3.2
      # @behaviour CanvasNative.V0.Type

      use Constructor

      @doc """
      Name for this type.
      """
      @spec type_name :: String.t
      def type_name, do: @type_name

      @doc """
      Get the prefix for this type.
      """
      @spec prefix(String.t) :: String.t
      def prefix(_), do: ""

      @doc """
      Match a Markdown string and return a struct or `nil`.
      """
      @spec match_markdown(String.t) :: t | nil
      def match_markdown(markdown) do
        if Regex.match?(@markdown_pattern, markdown) do
          "#{prefix markdown}#{markdown}"
          |> match_native
        end
      end

      @doc """
      Match a native string against `@native_pattern`, returning a struct or
      `nil`.
      """
      @spec match_native(String.t) :: t | nil
      def match_native(native) do
        case @native_pattern |> Regex.named_captures(native) do
          result when is_map(result) ->
            result
            |> Map.put(:source, native)
            |> Map.put(:type, @type_name)
            |> after_match_native
            |> new
          nil ->
            nil
        end
      end

      # Manipulate the match map before it is turned into a struct
      @spec after_match_native(%{source: String.t, type: String.t}) :: map
      defp after_match_native(map), do: map

      defoverridable(prefix: 1)
      defoverridable(match_markdown: 1)
      defoverridable(match_native: 1)
      defoverridable(after_match_native: 1)
    end
  end
end
