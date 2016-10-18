defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.split([" ", "_"])
    |> Enum.map(&(String.replace(&1, ~r/[^\w\-]/u, "")))
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&(String.downcase(&1)))
    |> Enum.reduce(%{}, fn(word, acc) ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
  end
end
