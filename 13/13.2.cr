people = Set{"Me"}
happiness = Hash({String, String}, Int32).new(0)

input = File.read("#{__DIR__}/input")
input.each_line do |line|
  if line =~ /(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)/
    first, verb, amount, second = $1, $2, $3.to_i, $4
    amount = -amount if verb == "lose"
    people << first
    people << second
    happiness[{first, second}] = amount
  end
end

max = 0
people.to_a.each_permutation do |permutation|
  current = 0
  permutation.each_with_index do |person, i|
    left = permutation[(i - 1) % people.size]
    right = permutation[(i + 1) % people.size]
    current += happiness[{person, left}]
    current += happiness[{person, right}]
  end
  max = current if current > max
end
puts max
