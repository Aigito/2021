# File reader
@input = []
File.open('q5input.txt', 'r') do |f|
  f.each_line do |line|
    temp_arr = line.scan(/\d+/)
    @input << [[temp_arr[0].to_i, temp_arr[1].to_i], [temp_arr[2].to_i, temp_arr[3].to_i]]
  end
end

# Part 2

@input.each do |line|
  line.sort_by! &:sum
end

p @input

# counter for each coordinate point within a hash table
@hash = {}

def counter(coordinate)
  if @hash.key?(coordinate)
    @hash[coordinate] += 1 if @hash[coordinate] < 2
  else
    @hash[coordinate] = 1
  end
end

# generate each point covered by each coordinate pair i.e. (0,1) & (0,3) will generate (0,1), (0,2), (0,3)
def generate_points(coordinate_pair)
  x1 = coordinate_pair.first[0]
  x2 = coordinate_pair.last[0]
  y1 = coordinate_pair.first[1]
  y2 = coordinate_pair.last[1]

  # Step 3: With each point generated, increase counter by 1 if it exists
  # OR, create a new key in the hash table and set value to 1
  if x1 == x2 # if verticle line
    (y1..y2).each { |point| counter([x1, point]) }
  elsif y1 == y2 # if horizontal line
    (x1..x2).each { |point| counter([point, y1]) }
  else # if diagonal line, instead of an if statement maybe do a when..case statement?
    # Situation 1: x1 < x2 and y1 < y2, then this is a top left to bottom right line (+1, +1 each time)
    # Situation 2: x1 < x2 and y1 > y2, then this is a bottom left to top right line (+1, -1 each time)

    # Ideally, the earlier sort function will not cause the bottom two situations but there may be outliers

    # Situation 3: x1 > x2 and y1 < y2, then this is a top right to bottom left line (-1, +1 each time)
    # Situation 4: x1 > x2 and y1 > y2, then this is a bottom right to top left line (-1, -1 each time)
  end
end

# # Part 1

# # get rid of ineligible coordinates (i.e diagonal lines)
# def check(input)
#   input.select! { |element| element.first[0] == element.last[0] || element.first[1] == element.last[1] }
#   input.each do |line|
#     line.sort_by! { |element| element.sum }
#   end
# end

# # counter for each coordinate point within a hash table
# @hash = {}

# def counter(coordinate)
#   if @hash.key?(coordinate)
#     @hash[coordinate] += 1 if @hash[coordinate] < 2
#   else
#     @hash[coordinate] = 1
#   end
# end

# # generate each point covered by each coordinate pair i.e. (0,1) & (0,3) will generate (0,1), (0,2), (0,3)
# def generate_points(coordinate_pair)
#   x1 = coordinate_pair.first[0]
#   x2 = coordinate_pair.last[0]
#   y1 = coordinate_pair.first[1]
#   y2 = coordinate_pair.last[1]

#   # Step 3: With each point generated, increase counter by 1 if it exists
#   if x1 == x2
#     (y1..y2).each { |point| counter([x1, point]) }

#     # OR, create a new key in the hash table and set value to 1
#   elsif y1 == y2
#     (x1..x2).each { |point| counter([point, y1]) }
#   end
# end

# # Step 1: Run check method to select only eligible coordinate pairs (i.e. horizontal & vertical)
# new_arr = check(@input)

# # Step 2: Generate each point on each horizontal / vertical line
# new_arr.each do |coordinate_pair|
#   generate_points(coordinate_pair)
# end

# p (@hash.select { |k, v| v > 1} ).size
