input = File.read("#{__DIR__}/input")
lines = input.lines
molecule = lines.pop
lines.pop
replacements = lines.map(&.split(" => ").map(&.chomp))

all = Set(String).new

replacements.each do |replacement|
  from, to = replacement
  offset = 0
  while index = molecule.index(from, offset)
    all << "#{molecule[0...index]}#{to}#{molecule[index + from.size..-1]}"
    offset = index + 1
  end
end

puts all.size
