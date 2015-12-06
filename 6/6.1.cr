lights = Array.new(1000) { Array.new(1000, false) }

input = File.read("#{__DIR__}/input")
input.each_line do |line|
  if line =~ /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/
    command = $1
    x1, y1, x2, y2 = {$2, $3, $4, $5}.map &.to_i
    (x1..x2).each do |x|
      (y1..y2).each do |y|
        case command
        when "turn on"
          lights[x][y] = true
        when "turn off"
          lights[x][y] = false
        when "toggle"
          lights[x][y] = !lights[x][y]
        end
      end
    end
  end
end

puts lights.sum &.count &.itself
