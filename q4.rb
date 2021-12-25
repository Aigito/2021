instructions = []
boards = []

# File reader
File.open('q4input.txt', 'r') do |f|
  f.each_line do |line|
    instructions << line
  end
end

# Replaces new line with empty string; helps to signify a new board
# Also deletes the "\n" on each line
instructions.each do |string|
  string.replace "" if string == "\n"
  string.delete! "\n"
end

# Store numbers to be picked in a new array
numbers = instructions.shift.split(',')

# Creating the boards

board_counter = -1

instructions.each do |line|
  if line == ""
    boards << []
  else
    boards[board_counter] << line.split(' ')
  end
end

# Win conditions
# 1. Row Bingo == Entire row 'single array within a board' is filled with 'X'
# 2  Column Bingo == Enture column 'multiple arrays of same index within a board' is filled with 'X'

# Playing the game

numbers.each do |number_called| # rubocop:disable Lint/UnreachableLoop
  num = number_called

  boards.each do |board|

    board.each do |row|
      row.each do |box|
        box.replace 'X' if box == num
      end
    end

  end

  break if num == "24"
end

p boards
