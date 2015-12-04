require "crypto/md5"

input = "ckczppom"
number = 1
until Crypto::MD5.hex_digest("#{input}#{number}").starts_with?("000000")
  number += 1
end
puts number
