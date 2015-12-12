require "json"

def sum(json)
  case json
  when Hash
    if json.any? { |k, v| v == "red" }
      0
    else
      json.values.sum { |elem| sum(elem) }
    end
  when Array
    json.sum { |elem| sum(elem) }
  when Int
    json
  else
    0
  end
end

input = File.read("#{__DIR__}/input")
json = JSON.parse(input)
puts sum(json)
