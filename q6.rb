# Hash table way

# File reader
@raw_input = []
File.open('q6input.txt', 'r') do |f|
  f.each_line do |line|
    @raw_input = (line.scan(/\d/)).map(&:to_i)
  end
end

# Hash builder
@hash = {
  0 => 0,
  1 => 0,
  2 => 0,
  3 => 0,
  4 => 0,
  5 => 0,
  6 => 0,
  7 => 0,
  8 => 0,
}

def builder(input)
  input.uniq.each do |days_left_in_pregnancy| # each days_left_in_pregnancy of fish in the pregnancy cycle
    @hash[days_left_in_pregnancy] = input.count(days_left_in_pregnancy)
  end
end

# countdown function for each day
def timer(input)
  newly_born_fish = input[0] # Day 0 fish
  input.each do |days_left_in_pregnancy, number_of_fish|

    # Creating newly born fish
    if days_left_in_pregnancy == 8
      input[days_left_in_pregnancy] = newly_born_fish
    elsif days_left_in_pregnancy == 6
      input[days_left_in_pregnancy] = newly_born_fish + input[days_left_in_pregnancy + 1]
    else
      input[days_left_in_pregnancy] = input[days_left_in_pregnancy + 1]
    end
  end
end

builder(@raw_input.sort!)

256.times do
  timer(@hash)
end

@hash.each do |k, v|
  puts "#{k}: #{v}"
end

puts @hash.values.inject { |a, b| a + b }

# puts ""
# puts ""

# check = [6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8]
# builder(check.sort!)

# @hash.each do |k, v|
#   puts "#{k}: #{v}"
# end

# Array way

# @input = []
# File.open('q6input.txt', 'r') do |f|
#   f.each_line do |line|
#     @input = (line.scan(/\d/)).map(&:to_i)
#   end
# end

# def timer(input)
#   input.each_with_index do |fish, index|
#     if fish > 0
#       input[index] -= 1
#     elsif fish == 0
#       input[index] = 6
#       input << 9
#     end
#   end
# end
