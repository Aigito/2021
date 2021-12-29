# File reader

raw_input = []

File.open('q8input.txt', 'r') do |f|
  f.each_line do |line|
    line.slice!(-1)
    raw_input << line
  end
end

def four_digit_generator(string)
  outputs = []

  4.times do
    string[-1] = "" if string[-1] == " "
    outputs.unshift(string.slice!(/\w+\z/))
  end

  outputs
end

def counter(input)
  result = 0

  input.each do |output_value|
    result += 1 if output_value.size == 2 || output_value.size == 3 || output_value.size == 4 || output_value.size == 7
  end

  result
end

@result = 0

raw_input.each do |string|
  arr = four_digit_generator(string)

  @result += counter(arr)
end

p @result

# Output
# If string size is:
# - 2 = 1
# - 3 = 7
# - 4 = 4
# - 7 = 7

# - 6 = 0 / 6 / 9
# - 5 = 2 / 3 / 5
