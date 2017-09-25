defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @flag_reverse 0b10000

  @actions [
    {0b00001, "wink"},
    {0b00010, "double blink"},
    {0b00100, "close your eyes"},
    {0b01000, "jump"},
  ]

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> find_actions()
    |> maybe_reverse(flag_is_on?(code, @flag_reverse))
  end

  @spec commands(code :: integer) :: list(String.t())
  defp find_actions(code) do
    for {flag, action} <- @actions,
      flag_is_on?(code, flag),
      do: action
  end

  @spec flag_is_on?(integer, integer) :: boolean
  defp flag_is_on?(code, flag) do
    (code &&& flag) != 0
  end

  @spec maybe_reverse(list(String.t()), boolean) :: list(String.t())
  defp maybe_reverse(actions, false),      do: actions
  defp maybe_reverse(actions, _reverse?),  do: Enum.reverse(actions)
end

