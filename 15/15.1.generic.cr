record Ingredient, capacity, durability, flavor, texture, calories

input = File.read("#{__DIR__}/input")
ingredients = input.each_line.map { |line|
  name, properties = line.split(':').map(&.strip)
  capacity, durability, flavor, texture, calories = properties.split(',').map(&.split[1].to_i64)
  Ingredient.new(capacity, durability, flavor, texture, calories)
}.to_a

max = 0_i64
(0..100).to_a.each_repeated_combination(4) do |comb|
  next unless comb.sum == 100

  comb.each_permutation do |perm|
    total = 1_i64
    {% for property in %w(capacity durability flavor texture).map(&.id) %}
      value = perm.size.times.reduce(0) { |memo, index| memo + perm[index] * ingredients[index].{{property}} }
      next if value <= 0
      total *= value
    {% end %}
    max = total if total > max
  end
end
puts max
