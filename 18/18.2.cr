input = File.read("#{__DIR__}/input")
current = input.lines.map &.chomp.chars.map { |c| c == '#' }
future = current.clone

w = current.size
h = current[0].size
steps = 100

def turn_on_edges(grid, w, h)
  grid[0][0] = true
  grid[0][h - 1] = true
  grid[w - 1][0] = true
  grid[w - 1][h - 1] = true
end

turn_on_edges current, w, h

steps.times do
  w.times do |i1|
    h.times do |j1|
      count = 0
      {i1 - 1, 0}.max.upto({i1 + 1, w - 1}.min) do |i2|
        {j1 - 1, 0}.max.upto({j1 + 1, h - 1}.min) do |j2|
          count += 1 if !(i1 == i2 && j1 == j2) && current[i2][j2]
        end
      end
      if current[i1][j1]
        future[i1][j1] = count == 2 || count == 3
      else
        future[i1][j1] = count == 3
      end
    end
  end

  turn_on_edges future, w, h

  current, future = future, current
end

puts current.sum &.count &.itself
