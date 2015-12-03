class Santa
  def initialize
    @x = 0
    @y = 0
  end

  def position
    {@x, @y}
  end

  def move(char)
    case char
    when '^' then @y -= 1
    when 'v' then @y += 1
    when '>' then @x += 1
    when '<' then @x -= 1
    end
  end
end

santa = Santa.new
robo_santa = Santa.new

visits = Set{ {0, 0} }

input = File.read("#{__DIR__}/input")
input.each_char_with_index do |char, i|
  current_santa = i.even? ? santa : robo_santa
  current_santa.move(char)
  visits << current_santa.position
end

puts visits.size
