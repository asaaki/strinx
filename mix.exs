defmodule Strinx.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @project_url "https://github.com/asaaki/strinx.ex"
  @docs_url "http://hexdocs.pm/strinx"

  def project do
    [
      app: :fnv,
      version: @version,
      elixir: "~> 1.2",
      deps: deps,
      package: package,
      description: description,
      source_url: @project_url,
      homepage_url: @docs_url,
      docs: &docs/0,
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application, do: []

  defp description,
    do: "Some string transformation functions for Elixir. Heavily inspired by ActiveSupport's String extensions (Ruby)."

  defp package do
    [
      maintainers: ["Christoph Grabo"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @project_url,
        "Docs" => "#{@docs_url}/#{@version}/"
      },
      files: package_files
    ]
  end

  defp package_files,
    do: ~w(lib mix.exs README.md LICENSE)

  defp docs do
    [
      extras: ["README.md"], main: "readme",
      source_ref: "v#{@version}", source_url: @project_url
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.3", only: [:lint, :ci]},
      {:ex_doc, "~> 0.11", only: [:docs, :ci]},
      {:cmark, "~> 0.6", only: [:docs, :ci]},
      {:inch_ex, "~> 0.5", only: [:docs, :ci]},
      {:excoveralls, "~> 0.5", only: [:ci]},
    ]
  end
end
