index1 = 0
o2arr = []

# Part 1

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


# Part 2

1000.times do
  o2.each do |array|
    o2arr << array[index1]
  end

  num = (o2arr.count 0) > (o2arr.count 1) ? 0 : 1

  o2.select! { |array| array[index1] == num }
  o2arr = []
  index1 += 1

  break if o2.length == 1
end

index2 = 0
co2arr = []

1000.times do
  co2.each do |array|
    co2arr << array[index2]
  end

  num = (co2arr.count 0) > (co2arr.count 1) ? 1 : 0

  co2.select! { |array| array[index2] == num }
  co2arr = []
  index2 += 1

  break if co2.length == 1
end

p (o2.first.join("")).to_i(2) * (co2.first.join("")).to_i(2)
