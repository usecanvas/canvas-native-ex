defmodule Constructor do
  @moduledoc """
  Constructs a struct from the given map, turning string keys into atoms where
  necessary.

  ## Usage

      iex> defmodule DocModule do
      ...>   defstruct foo: ""
      ...>   @type t :: %__MODULE__{foo: String.t}
      ...>   use Constructor
      ...> end
      iex> DocModule.new(%{"foo" => "bar", baz: "qux"})
      %{__struct__: ConstructorTest.DocModule, baz: "qux", foo: "bar"}
  """

  defmacro __using__(_opts) do
    quote do
      @spec new(map) :: t
      def new(map) do
        map
        |> Enum.reduce(%__MODULE__{}, fn ({key, value}, result) ->
          result
          |> Map.put(Constructor.get_key(key), map[key])
        end)
      end
    end
  end

  @doc """
  Get a key for a given key (convert it to an atom if necessary).
  """
  @spec get_key(String.t | atom) :: atom
  def get_key(key) when is_binary(key) do
    key |> String.to_atom
  end

  def get_key(key), do: key
end
