# Modifies chars to the next sequence, only skipping invaild letters.
def succ(chars)
  i = chars.size - 1
  while true
    char = chars[i]
    char = char.succ

    # Optimization: skip invalid chars right here
    char = char.succ if invalid_char?(char)

    if char > 'z'
      chars[i] = 'a'
      i -= 1
      if i < 0
        i = 0
        chars.unshift 'a'
        break
      end
    else
      chars[i] = char
      break
    end
  end
end

def invalid_char?(char)
  char == 'i' || char == 'o' || char == 'l'
end

def has_invalid_char?(chars)
  chars.any? { |char| invalid_char?(char) }
end

def has_stair?(chars)
  (0..chars.size - 3).any? do |i|
    chars[i].succ == chars[i + 1] && chars[i + 1].succ == chars[i + 2]
  end
end

def has_two_pairs?(chars)
  pairs = 0
  i = 0
  while i < chars.size - 1
    if chars[i] == chars[i + 1]
      pairs += 1
      return true if pairs == 2

      # If the next char is the same, we skip it
      i += 1 if chars[i + 1]? == chars[i]
    end
    i += 1
  end
  false
end

def valid?(chars)
  !has_invalid_char?(chars) && has_stair?(chars) && has_two_pairs?(chars)
end

input = "hxbxxyzz"
chars = input.chars
loop do
  succ(chars)
  break if valid?(chars)
end
puts chars.join
