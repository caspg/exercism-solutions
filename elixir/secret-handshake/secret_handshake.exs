defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @flag_reverse 16

  @action_flags [
    1,
    2,
    4,
    8,
  ]

  @actions %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump",
  }

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
    @action_flags
    |> Enum.map(fn(flag) -> map_code_to_action(code, flag) end)
    |> Enum.filter(fn(action) -> !is_nil(action) end)
    |> maybe_reverse(flag_is_on?(code, @flag_reverse))
  end

  @spec map_code_to_action(integer, integer) :: String.t | nil
  defp map_code_to_action(code, flag) do
    case flag_is_on?(code, flag) do
      true  -> @actions[flag]
      false -> nil
    end
  end

  @spec flag_is_on?(integer, integer) :: boolean
  defp flag_is_on?(code, flag) do
    (code &&& flag) != 0
  end

  @spec maybe_reverse(list(String.t()), boolean) :: list(String.t())
  defp maybe_reverse(actions, false), do: actions
  defp maybe_reverse(actions, true),  do: Enum.reverse(actions)
end

