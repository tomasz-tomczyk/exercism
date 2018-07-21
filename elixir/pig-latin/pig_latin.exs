defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    cond do
      String.match?(phrase, ~r/\s/) -> String.split(phrase, ~r/\s/) |> Enum.map(&translate/1) |> Enum.join(" ")
      String.match?(phrase, ~r/^(([yx][b-df-hj-np-tv-z])|[aeuio]).*/) -> phrase <> "ay"
      String.match?(phrase, ~r/^(ch|qu|squ|thr|th|sch|[b-df-hj-np-tv-z])+/) ->
        Regex.split(~r/^(ch|qu|squ|thr|th|sch|[b-df-hj-np-tv-z])+/, phrase, include_captures: true, trim: true)
        |> List.insert_at(0, "ay")
        |> Enum.reverse()
        |> List.to_string()
      true -> phrase
    end
  end
end
