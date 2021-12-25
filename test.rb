# File reader
File.open('q5input.txt', 'r') do |f|
  f.each_line do |line|
    p line.scan(/\d/)
  end
end
