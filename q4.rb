input = [
  [[0,9], [5,9]],
  [[8,0], [0,8]],
  [[9,4], [3,4]],
  [[2,2], [2,1]],
  [[7,0], [7,4]],
  [[0,9], [2,9]],
  [[6,4], [2,0]],
  [[3,4], [1,4]],
  [[0,0], [8,8]],
  [[5,5], [8,2]]
]

# get rid of ineligible coordinates (i.e NOT a verticle or horizontal line)
def check(input)
    input.select! { |element| element.first[0] == element.last[0] || element.first[1] == element.last[1]}
end

def generate_points(coordinate)
    if coordinate.first[0] == coordinate.last[0]
        (coordinate.first[1]..coordinate.last[1]).each { |point| @arr << [coordinate.first[0], point] }
    end
end

@arr = []

generate_points([[7,0], [7,4]])

print @arr
