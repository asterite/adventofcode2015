def look_and_say(string)
  last = nil
  count = 0
  String.build do |result|
    string.each_char do |char|
      if last && last != char
        result << count << last
        count = 0
      end
      last = char
      count += 1
    end
    result << count << last
  end
end

input = "1321131112"
50.times do
  input = look_and_say(input)
end
puts input.size
