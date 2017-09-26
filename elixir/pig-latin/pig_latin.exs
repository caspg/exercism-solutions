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
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word(&1))
    |> Enum.join(" ")
  end

  @vowels ["a", "e", "i", "o", "u"]
  @consonant_clusters ["ch", "qu", "th", "thr", "sch"]
  @vowels_clustsers ["yt", "xr"]

  @spec translate_word(String.t()) :: String.t()

  defp translate_word(<<h::binary-3, t::binary>>)
        when h in @consonant_clusters, do: translate_word(t <> h)

  defp translate_word(<<h::binary-2, t::binary>>)
       when h in @consonant_clusters, do: translate_word(t <> h)

  defp translate_word(<<h::binary-2, t::binary>>)
       when h in @vowels_clustsers, do: h <> t <> "ay"

  defp translate_word(<<h::binary-1, t::binary>>)
       when h in @vowels, do: h <> t <> "ay"

  defp translate_word(<<h::binary-1, t::binary>>), do: translate_word(t <> h)
end
