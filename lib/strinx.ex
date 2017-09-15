defmodule Strinx do

  # underscores to camelcases

  def camelcase(input), do: camelize(input, "", true)

  def camelcase(input, first_letter_flag), do: camelize(input, "", first_letter_flag)

  def camelize(""),    do: ""
  def camelize(input), do: camelize(input, "", true)

  def camelize("", _first_letter_flag), do: ""
  def camelize(input, first_letter_flag) do
    # to_upper = first_letter_flag != :lower
    to_upper = first_letter_flag
    camelize(input, "", to_upper)
  end

  defp camelize("", output, _to_upper), do: output
  defp camelize(<< "_", rest :: binary >>, output, _to_upper) do
    camelize(rest, output, true)
  end
  defp camelize(<< char :: utf8, rest :: binary >>, output, to_upper) do
    char = if to_upper == :upper, do: String.upcase(<< char :: utf8 >>), else: String.downcase(<< char :: utf8 >>)
    camelize(rest, output <> char, false)
  end

  # underscores to dashes

  def dasherize(input), do: String.replace(input, "_", "-")

  # camelcases to underscores

  # FIXME: "FooBar FuuBaz" => "foo_bar _fuu_baz"
  # inner leading underscores (` _fuu_baz` => ` fuu_baz`) need to be eliminated, too.

  def underscore(input) do
    input
    |> String.graphemes
    |> Enum.map(&underscore_char/1)
    |> List.to_string
    |> strip_leading_underscore
  end

  defp underscore_char(char) do
    case noncapital?(char) do
      true  -> char
      false -> "_" <> String.Unicode.downcase(char)
    end
  end

  defp noncapital?(char) do
    String.Unicode.downcase(char) == char
  end

  defp strip_leading_underscore(<< "_", output :: binary >>), do: output
  defp strip_leading_underscore(output), do: output
end
