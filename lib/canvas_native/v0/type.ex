alias CanvasNative.V0.MarkdownParser

defmodule CanvasNative.V0.Type do
  @moduledoc """
  Describes a type of line in a canvas.
  """

  # Re-add in Elixir 1.3.2
  # @callback match_native(String.t) :: struct | nil

  defmacro __using__(opts) do
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
      Match a Markdown string and return a struct or `nil`.
      """
      @spec match_markdown(String.t, MarkdownParser.context) :: t | nil
      def match_markdown(markdown,
        ctx \\ %{has_title: false, in_code: false, last_line_blank: false})

      def match_markdown(markdown, ctx) do
        if Regex.match?(@markdown_pattern, markdown) do
          "#{prefix markdown, ctx}#{markdown}"
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

      # Get the prefix for this type.
      @spec prefix(String.t, MarkdownParser.context) :: String.t
      if unquote(opts[:has_prefix]) do
        defp prefix(_, _) do
          wrap(@type_name)
        end
      else
        defp prefix(_, _), do: ""
      end

      defoverridable(prefix: 2)
      defoverridable(match_markdown: 2)
      defoverridable(match_native: 1)
      defoverridable(after_match_native: 1)
    end
  end
end
