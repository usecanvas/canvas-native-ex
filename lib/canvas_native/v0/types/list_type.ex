alias CanvasNative.V0.Type

defmodule CanvasNative.V0.ListType do
  @moduledoc """
  A type representing an item in a list.
  """

  defmacro __using__(_opts) do
    quote do
      use Type

      def prefix(md) do
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
    end
  end
end
