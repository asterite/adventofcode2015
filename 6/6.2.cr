lights = Array.new(1000) { Array.new(1000, 0) }

input = File.read("#{__DIR__}/input")
input.each_line do |line|
  if line =~ /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/
    command = $1
    x1, y1, x2, y2 = {$2, $3, $4, $5}.map &.to_i
    (x1..x2).each do |x|
      (y1..y2).each do |y|
        case command
        when "turn on"
          lights[x][y] += 1
        when "turn off"
          lights[x][y] = {lights[x][y] - 1, 0}.max
        when "toggle"
          lights[x][y] += 2
        end
      end
    end
  end
end

puts lights.sum &.sum
