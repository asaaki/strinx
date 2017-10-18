defmodule Strinx do
  @moduledoc """
  Some string transformation functions for Elixir

  Heavily inspired by ActiveSupport's String extensions (Ruby).
  """

  alias String.Casing

  @doc "`foo_bar` to `FooBar`"
  def camelcase(input),
    do: camelize(input, "", true)

  @doc """
  Like Strinx.camelcase/1, but you can specify if the first letter should be
  lowercase by setting `first_letter_flag` to `:lower`.

  ## Example

      Strinx.camelcase("foo_bar", :lower)
      #=> "fooBar"
  """
  def camelcase(input, first_letter_flag),
    do: camelize(input, first_letter_flag)

  @doc false
  def camelize(input),
    do: camelize(input, "", true)

  @doc false
  def camelize("", _),
    do: ""
  def camelize(input, first_letter_flag),
    do: camelize(input, "", first_letter_flag != :lower)

  defp camelize("", output, _to_upper), do: output
  defp camelize(<< "_", rest :: binary >>, output, _to_upper),
    do: camelize(rest, output, true)
  defp camelize(<< char :: utf8, rest :: binary >>, output, to_upper),
    do: camelize(rest, output <> maybe_upcase(to_upper, char), false)

  defp maybe_upcase(true, char),
    do: String.upcase(<< char :: utf8 >>)
  defp maybe_upcase(false, char),
    do: << char :: utf8 >>

  @doc "`foo_bar` to `foo-bar`"
  def dasherize(input),
    do: String.replace(input, "_", "-")

  @doc "`FooBar` to `foo_bar`"
  # FIXME: "FooBar FuuBaz" => "foo_bar _fuu_baz"
  # inner leading underscores (` _fuu_baz` => ` fuu_baz`) need to be eliminated, too.
  def underscore(input) do
    input
    |> String.graphemes
    |> Enum.map(&underscore_char/1)
    |> List.to_string
    |> strip_leading_underscore
  end

  defp underscore_char(char),
    do: maybe_underscore(noncapital?(char), char)

  defp maybe_underscore(true, char),
    do: char
  defp maybe_underscore(false, char),
    do: "_" <> Casing.downcase(char)

  defp noncapital?(char),
    do: Casing.downcase(char) == char

  defp strip_leading_underscore(<< "_", output :: binary >>),
    do: output
  defp strip_leading_underscore(output),
    do: output
end
