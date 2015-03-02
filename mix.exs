defmodule Strinx.Mixfile do
  use Mix.Project

  def project do
    [
      app:           :strinx,
      version:       "0.1.0",
      elixir:        "~> 1.0",
      deps:          deps,
      package:       package,
      description:   "Some string transformation functions for Elixir. Heavily inspired by ActiveSupport's String extensions (Ruby).",
      name:          "strinx",
      source_url:    "https://github.com/asaaki/strinx.ex",
      homepage_url:  "http://hexdocs.pm/strinx",
      docs:          &docs/0,
      test_coverage: [tool: ExCoveralls]
   ]
  end

  def application, do: []

  defp package do
    [
      contributors: ["Christoph Grabo"],
      licenses:     ["MIT"],
      links: %{
        "GitHub" => "https://github.com/asaaki/strinx.ex",
        "Issues" => "https://github.com/asaaki/strinx.ex/issues",
        "Docs"   => "http://hexdocs.pm/strinx/"
      },
      files: [
        "lib",
        "LICENSE",
        "mix.exs",
        "README.md",
        "src"
      ]
    ]
  end

  defp docs do
    {ref, 0} = System.cmd("git", ["rev-parse", "--verify", "--quiet", "HEAD"])
    [
      source_ref: ref,
      readme:     "README.md",
      main:       "README"
    ]
  end

  defp deps do
    [
      { :excoveralls, "~> 0.3", only: [:dev, :test] },
      { :ex_doc,      "~> 0.7", only: :docs },
      { :earmark,     "~> 0.1", only: :docs },
      { :inch_ex,     "~> 0.2", only: :docs }
    ]
  end
end
