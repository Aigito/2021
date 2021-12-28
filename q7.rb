# File reader
all_crabs = {}

File.open('q7input.txt', 'r') do |f|
  temp = []
  f.each_line do |line|
    temp = (line.scan(/\d+/)).map(&:to_i)
  end

  temp.sort.uniq.each do |crab_position| # each crab and their position
    all_crabs[crab_position] = temp.count(crab_position)
  end
end

# Save the lowest and highest possible numbers of the array
min = all_crabs.keys.min
max = all_crabs.keys.max

# With both min and max, this will create an array with that as the min max range
range = []

(min..max).each do |num|
  range << num
end

# p "Sorted raw input: #{all_crabs}"
# p "Min value: #{min}"
# p "Max value: #{max}"
# p "Range: #{range}"

# Step 1: Need a function that splits the crab positions into two categories:
@left_half = {}
@right_half = {}

def splitter(crabs, position)
  # Category 1 (LH): Crab positions that are less than the current position we are checking (i.e. if we are checking position 5, then all pos 0 - 4 crabs are in cat 1
  @left_half = crabs.select { |k, v| k < position}

  # Category 2 (RH): Crab positions that are greater than or equal to the current position we are checking (i.e. if we are checking position 5, then all pos 5 - max are in cat 2)
  @right_half = crabs.reject { |k,v| k < position }
end

@left_sum = 0
@right_sum = 0

# Step 2: Run through each number from min to max, and calculate the amount of fuel required to move all crabs to that current position
def fuel_required_to_move_to(crabs, position)
  # Call splitter method to get the left and right side respectively
  splitter(crabs, position) # this will return both left and right hash tables

  # Petrol (for each side) = Sum of all keys * value (crab position * number of crabs) - current position * number of crabs
  @left_sum = 0
  @left_half.each { |k, v| @left_sum += k * v }

  @right_sum = 0
  @right_half.each { |k, v| @right_sum += k * v }

  @right_sum - (position * @right_half.values.sum) + (position * @left_half.values.sum) - @left_sum
end

# Step 3: Check and compare the amount of fuel required from pos X to pos X + 1 to see if it is more efficient (less fuel)
current = previous = least_amount_of_fuel = 999,999,999


range.each do |position|
  current = fuel_required_to_move_to(all_crabs, position)

  if current < previous
    least_amount_of_fuel = current
  end

  previous = current
end

p least_amount_of_fuel
