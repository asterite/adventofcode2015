# This isn't the right way to solve the problem, it seems that the solution
# was in the input given (https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4etju)
# but this still finds the correct solution for my input, though it never finishes.
input = File.read("#{__DIR__}/input")
lines = input.lines
molecule = lines.pop
lines.pop
replacements = lines.map(&.split(" => ").map(&.chomp))
replacements.sort_by! { |r| -r[1].size }

def reduce(molecule, replacements, count, mins)
  replacements.each do |replacement|
    from, to = replacement
    offset = 0
    while index = molecule.index(to, offset)
      reduced = "#{molecule[0...index]}#{from}#{molecule[index + to.size..-1]}"

      unless (existing = mins[reduced]?) && existing <= count + 1
        mins[reduced] = count + 1

        if reduced == "e"
          puts count + 1
          return
        else
          reduce(reduced, replacements, count + 1, mins)
        end
      end

      offset = index + 1
    end
  end
end

mins = {} of String => Int32
mins[molecule] = 0
reduce(molecule, replacements, 0, mins)
puts mins["e"]
