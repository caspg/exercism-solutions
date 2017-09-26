defmodule TwelveDays do
  @gifts [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming",
  ]

  @days ~w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    begining(number) <> gifts(number) <> "."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    (for day <- starting_verse..ending_verse, do: verse(day))
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end

  @spec begining(number :: integer) :: String.t()
  defp begining(number) do
    day = Enum.at(@days, number - 1)
    "On the #{day} day of Christmas my true love gave to me, "
  end

  @spec gifts(number :: integer) :: String.t()
  defp gifts(1), do: gifts_from_day(1)
  defp gifts(2), do: gifts_from_day(2) <> ", and #{gifts(1)}"
  defp gifts(n), do: gifts_from_day(n) <> ", #{gifts(n - 1)}"

  @spec gifts_from_day(number :: integer) :: String.t()
  defp gifts_from_day(number), do: Enum.at(@gifts, number - 1)
end

