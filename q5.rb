@input = []

# File reader
File.open('q5input.txt', 'r') do |f|
  f.each_line do |line|
    temp_arr = line.scan(/\d+/)
    @input << [[temp_arr[0].to_i, temp_arr[1].to_i], [temp_arr[2].to_i, temp_arr[3].to_i]]
  end
end

# get rid of ineligible coordinates (i.e diagonal lines)
def check(input)
  input.select! { |element| element.first[0] == element.last[0] || element.first[1] == element.last[1] }
  input.each do |line|
    line.sort_by! { |element| element.sum }
  end
end

# counter for each coordinate point within a hash table
@hash = {}

def counter(coordinate)
  if @hash.key?(coordinate)
    @hash[coordinate] += 1
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
  if x1 == x2
    (y1..y2).each { |point| counter([x1, point]) }

    # OR, create a new key in the hash table and set value to 1
  elsif y1 == y2
    (x1..x2).each { |point| counter([point, y1]) }
  end
end

# Step 1: Run check method to select only eligible coordinate pairs (i.e. horizontal & vertical)
new_arr = check(@input)

# Step 2: Generate each point on each horizontal / vertical line
new_arr.each do |coordinate_pair|
  generate_points(coordinate_pair)
end

p (@hash.select { |k, v| v > 1} ).size
