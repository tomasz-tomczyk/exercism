defmodule SecretHandshake do
  use Bitwise
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

  @commands ["wink", "double blink", "close your eyes", "jump"]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    @commands
    |> Enum.with_index
    |> Enum.map(fn({command, index}) ->
      {command, 1 <<< index}
    end)
    |> Enum.map(&decode_command(&1, code))
    |> Enum.reject(&(&1 == nil))
    |> reverse_if_needed(code)
  end

  def decode_command({command, flag}, code) do
    case (code &&& flag) === flag do
      true -> command
      false -> nil
    end
  end

  def reverse_if_needed(commands, code) when (code &&& 16) == 16 do
    commands |> Enum.reverse
  end
  def reverse_if_needed(commands, _code), do: commands

  # def to_binary(code) do
  #   Integer.to_string(code, 2)
  #   |> Integer.parse
  #   |> elem(0)
  # end
end

