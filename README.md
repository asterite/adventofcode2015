# adventofcode
Solutions to http://adventofcode.com/ in Crystal

## The way code is written

Code is written with readability in mind, not maximum efficiency. However,
it can be made more efficient, either in terms of memory or running time.

For example, instead of doing `File.read(...)` one can open the file and
read line by line, even using an iterator in some cases:
`File.open(...).each_line.count { ... }`.

## Running

Simply do, for example, `crystal 1/1.1.cr`, `crystal 2/2.1.cr`, etc.
