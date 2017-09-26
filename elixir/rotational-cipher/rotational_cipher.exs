defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    (for char <- String.to_charlist(text), do: maybe_rotate(char, shift))
    |> to_string()
  end

  @spec maybe_rotate(char :: char, shift :: integer) :: char
  defp maybe_rotate(char, shift) when char in ?a..?z, do: roate_char(char, shift, ?a)
  defp maybe_rotate(char, shift) when char in ?A..?Z, do: roate_char(char, shift, ?A)
  defp maybe_rotate(char, _),                         do: char

  @spec roate_char(char :: char, shift :: integer, low :: integer)  :: char
  defp roate_char(char, shift, low) do
    low + rem(char - low + shift, 26)
  end
end

