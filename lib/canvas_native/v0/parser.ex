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
end
