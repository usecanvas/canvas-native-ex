defmodule ConstructorTest do
  use ExUnit.Case, async: true
  doctest Constructor

  defmodule MyModule do
    defstruct foo: ""
    @type t :: %__MODULE__{foo: String.t}
    use Constructor
  end

  test "adds a .new that converts strings to atoms" do
    assert MyModule.new(%{"foo" => "bar"}) == %MyModule{foo: "bar"}
  end
end
