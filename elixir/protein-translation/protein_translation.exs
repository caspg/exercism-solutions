defmodule ProteinTranslation do
  @type string_list :: list(String.t())

  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case @proteins[codon] do
      nil     -> { :error, "invalid codon" }
      protein -> { :ok,    protein }
    end
  end

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(rna :: String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    rna |> codon_list() |> translate_codons([])
  end

  @spec of_rna(rna :: String.t()) :: list(String.t())
  defp codon_list(rna) do
    rna
    |> String.split(~r/.{3}/, include_captures: true, trim: true)
  end

  @spec translate_codons(string_list, string_list) :: { atom, string_list }
  def translate_codons([], proteins), do: { :ok, proteins }

  def translate_codons([codon | codons_tail], proteins) do
    case of_codon(codon) do
      { :ok, "STOP" } ->
        translate_codons([], proteins)
      { :ok, protein } ->
        translate_codons(codons_tail, proteins ++ [protein])
      _ ->
        { :error, "invalid RNA" }
    end
  end
end

