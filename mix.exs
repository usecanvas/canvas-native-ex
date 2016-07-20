defmodule CanvasNative.Mixfile do
  use Mix.Project

  @version "1.0.0"
  @github_url "https://github.com/usecanvas/canvas-native-ex"

  def project do
    [app: :canvas_native,
     description: description,
     version: @version,
     package: package,
     name: "CanvasNative",
     elixir: "~> 1.3",
     aliases: aliases,
     homepage_url: @github_url,
     source_url: @github_url,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     dialyzer: [plt_add_deps: true],
     docs: docs,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    CanvasNative is a format used to describe documents on the canvas platform.
    This library provides modules for parsing and formatting the CanvasNative
    format.
    """
  end

  defp package do
    [licenses: "MIT",
     maintainers: ["Jonathan Clem <jonathan@usecanvas.com>"],
     links: %{"GitHub" => "https://github.com/usecanvas/canvas-native-ex"}]
  end

  defp docs do
    [extras: ["README.md", "LICENSE.md"],
     main: "CanvasNative",
     source_ref: "v#{@version}"]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:poison, "~> 2.2.0"},
     {:credo, "~> 0.4", only: [:dev, :test]},
     {:dialyxir, "~> 0.3.5", only: [:dev, :test]}]
  end

  defp aliases do
    [test: ["test", "credo --strict"]]
  end
end
