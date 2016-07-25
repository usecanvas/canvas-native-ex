alias CanvasNative.V0.Type

defmodule CanvasNative.V0.ListType do
  @moduledoc """
  A type representing an item in a list.
  """

  defmacro __using__(_opts) do
    quote do
      use Type, has_prefix: true

      def as_json(struct) do
        %{
          type: @type_name,
          text: struct.content,
          meta: %{level: struct.level}
        }
      end

      defp prefix(md, _) do
        whitespace =
          ~r/^( *)/
          |> Regex.run(md)
          |> Enum.at(0)
          |> String.length

        level =
          whitespace
          |> Kernel./(2)
          |> Float.ceil
          |> round

        wrap(@type_name <> "-#{level}")
      end

      defoverridable(as_json: 1)
    end
  end
end
