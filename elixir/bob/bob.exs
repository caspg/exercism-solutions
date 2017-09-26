defmodule Bob do
  @empty_string_reg ~r/^\s*$/
  @only_numbers_reg ~r/^[0-9,\s]+$/
  @shouting_reg ~r/^[^a-z]*[^?]$/
  @question_reg ~r/\?$/

  def hey(input) do
    cond do
        input =~ @empty_string_reg -> "Fine. Be that way!"
        input =~ @only_numbers_reg -> "Whatever."
        input =~ @shouting_reg     -> "Whoa, chill out!"
        input =~ @question_reg     -> "Sure."
        true                       -> "Whatever."
    end
  end
end
