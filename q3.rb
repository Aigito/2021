i = 0
temp = ""
arr = []

input.first.length.times do
  input.each do |str|
    temp += str[i]
  end

  i += 1
  arr << temp
  temp = ""
end

gamma = ""
epsilon = ""

arr.each do |str|
  if (str.count "0") > (arr.first.length/2)
    gamma += "0"
    epsilon += "1"
  elsif (str.count "1") > (arr.first.length/2)
    gamma += "1"
    epsilon += "0"
  end
end

puts gamma.to_i(2) * epsilon.to_i(2)

# Step 1: Find the most common bit of the first column and store in a variable

# Step 2: With the variable, keep the string that has that number as their first number

# Step 3: Find the most common bit of the second column and store in a variable

# Step 4: With the variable, keep the string that has that number as their second number

### Continue this cycle until only one string remains
