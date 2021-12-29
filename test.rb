# File reader
str_digits = []

File.open('q8input.txt', 'r') do |f|
  f.each_line do |line|
    line.chomp!
    str_digits = line.scan(/\w+/)
  end
end
# In this file, we will create two seperate methods

translator_hash = {}
segment_hash = {}
size5 = []
size6 = []

# Method 1: Decoder (to link each segment with a letter i.e. top = a / bottom = g)
str_digits.each do |str|
  str = str.chars.sort.join

  case str.size
  when 2
    translator_hash[1] = str
    segment_hash['complete-right'] = str
  when 3
    translator_hash[7] = str
  when 4
    translator_hash[4] = str
  when 7
    translator_hash[8] = str
  when 5
    size5 << str
  when 6
    size6 << str
  end
end

# Segment Step 1: Identify top segment
top = segment_hash['top'] = (translator_hash[7].split('') - translator_hash[1].split('')).join

four_plus_top_segment = (translator_hash[4] + top).chars.sort

# Translator Step 1: Create number 9 (number 4 + 'top')
size6.each do |digit|
  match = false
  four_plus_top_segment.each do |char|
    match = digit.include?(char)
    break if match == false
  end

  if match
    translator_hash[9] = digit

    # Segmenet Step 2: Identify bottom segment, AFTER identifying number 9
    segment_hash['bottom'] = (digit.chars - four_plus_top_segment)[0]
    size6.delete(digit)
    break
  end
end

# Segment Step 3: Identify bottom left segment, which is the only missing segment in number 9
segment_hash['bottom-left'] = (translator_hash[8].chars - translator_hash[9].chars).join

# Translator Step 2: Creating number 6 (only size 6 number without complete right segment)



puts "Initial translator hash with 1 / 4 / 7 / 8: #{translator_hash} - Line 41"
puts "Initial segment hash : #{segment_hash} - Line 42"
puts "Size 5s: #{size5} - Line 43"
puts "Size 6s: #{size6} - Line 44"

# Method 2: Constructor (after deciphering the code, reconstruct each number with the correct "light up" segments)
# (i.e. ab = 1 ; abe = 7; etc)
