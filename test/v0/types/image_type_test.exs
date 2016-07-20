alias CanvasNative.V0.ImageType

defmodule CanvasNative.V0.ImageTypeTest do
  use ExUnit.Case, async: true

  import ImageType
  import CanvasNative.V0.Brackets

  doctest ImageType

  describe ".match_native" do
    test "matches a native image into a struct" do
      url = "https://example.com/foo.png"
      source = "#{wrap(type_name <> "-{}")}#{url}"
      assert source |> match_native ==
        %ImageType{content: url, source: source, type: type_name, url: url,
                   metadata: %{}}
    end

    test "matches a native image into a struct with a metadata URL" do
      url = "https://example.com/foo.png"
      source = "#{wrap(type_name <> ~s(-{"url": "foo"}))}#{url}"
      assert source |> match_native ==
        %ImageType{content: url, source: source, type: type_name, url: "foo",
                   metadata: %{"url" => "foo"}}
    end

    test "matches a native image into a struct with no metadata" do
      url = "https://example.com/foo.png"
      source = "#{wrap(type_name)}#{url}"
      assert source |> match_native ==
        %ImageType{content: url, source: source, type: type_name, url: url,
                   metadata: %{}}
    end

    test "matches a native image into a struct with invalid metadata" do
      url = "https://example.com/foo.png"
      source = "#{wrap(type_name <> "-{")}#{url}"
      assert source |> match_native ==
        %ImageType{content: url, source: source, type: type_name, url: url,
                   metadata: %{}}
    end
  end
end
