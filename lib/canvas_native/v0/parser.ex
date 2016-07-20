alias CanvasNative.V0.{BlockquoteType, ChecklistType, CodeType, HeadingType,
                       HorizontalRuleType, ImageType, LinkDefinitionType,
                       OrderedListType, ParagraphType, TitleType,
                       UnorderedListType}

defmodule CanvasNative.V0.Parser do
  @moduledoc """
  Parses a string into a list of maps representing parsed lines.
  """

  @callback parse(String.t) :: list(map)

  @doc """
  Get the order of types as they should be parsed.
  """
  def parse_order do
    [ChecklistType, BlockquoteType, CodeType, TitleType, HeadingType,
     HorizontalRuleType, ImageType, LinkDefinitionType, OrderedListType,
     UnorderedListType, ParagraphType]
  end

  @doc """
  Return a function that tries to match against a type module for `line` using
  the given function name.
  """
  @spec try_match([any], atom) ::
    ((module, nil) -> {:halt, map} | {:cont, nil})
  def try_match(args, func_name) do
    fn (type, nil) ->
      case apply(type, func_name, args) do
        result when not is_nil(result) -> {:halt, result}
        nil -> {:cont, nil}
      end
    end
  end
end
