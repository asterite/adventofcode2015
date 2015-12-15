record Ingredient, capacity, durability, flavor, texture, calories

input = File.read("#{__DIR__}/input")
ingredients = input.each_line.map { |line|
  name, properties = line.split(':').map(&.strip)
  capacity, durability, flavor, texture, calories = properties.split(',').map(&.split[1].to_i64)
  Ingredient.new(capacity, durability, flavor, texture, calories)
}.to_a

max = 0_i64
(0..100).each do |i1|
  (0..100 - i1).each do |i2|
    (0..100 - i1 - i2).each do |i3|
      i4 = 100 - i1 - i2 - i3

      total = 1_i64
      {% for property in %w(capacity durability flavor texture).map(&.id) %}
        value = i1 * ingredients[0].{{property}} + i2 * ingredients[1].{{property}} + i3 * ingredients[2].{{property}} + i4 * ingredients[3].{{property}}
        next if value <= 0
        total *= value
      {% end %}

      max = total if total > max
    end
  end
end
puts max
