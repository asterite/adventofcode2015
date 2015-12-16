target = {
  "children":    3,
  "cats":        7,
  "samoyeds":    2,
  "pomeranians": 3,
  "akitas":      0,
  "vizslas":     0,
  "goldfish":    5,
  "trees":       3,
  "cars":        2,
  "perfumes":    1,
}

input = File.read("#{__DIR__}/input")
sues = input.lines.map do |line|
  first, second = line.split(':', 2)
  sue = {"Number": first.split[1].to_i}
  second.split(',').each do |piece|
    name, value = piece.split(':')
    sue[name.strip] = value.to_i
  end
  sue
end
sue = sues.max_by do |sue|
  target.each.count do |key_value|
    key, value = key_value
    sue_value = sue[key]?
    next unless sue_value
    case key
    when "cats", "trees"
      sue_value > value
    when "pomeranians", "goldfish"
      sue_value < value
    else
      sue_value == value
    end
  end
end
puts sue["Number"]
