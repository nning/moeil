# Monkey-patch the String class.
class String
  # Random index in string.
  def random_index
    rand(size - 1)
  end

  # Random substring of string.
  def random_substring
    a = [0, 0].map { random_index }.sort
    self[a[0]..a[1]]
  end
end
