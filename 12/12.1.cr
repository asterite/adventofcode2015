require "json"

sum = 0
File.open("#{__DIR__}/input") do |file|
  lexer = JSON::Lexer.new(file)
  while (token = lexer.next_token).type != :EOF
    if token.type == :INT
      sum += token.int_value
    end
  end
end
puts sum
