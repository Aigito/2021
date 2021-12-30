# File reader
@input_array = []
@output_array = []

@numbers_hash = {}
@segment_hash = {}

@sum = 0

def seperator(string)
  @input_array = []
  @output_array = []

  4.times do
    string[-1] = "" if string[-1] == " "
    @output_array.unshift(string.slice!(/\w+\z/).chars.sort.join)
  end

  10.times do
    string[0] = "" if string[0] == " "
    @input_array.push(string.slice!(/\A\w+/))
  end
end

def constructor(input_array)
  @numbers_hash = {}
  @segment_hash = {}
  size5 = []
  size6 = []

  @input_array.each do |str|
    str = str.chars.sort.join

    case str.size
    when 2
      @numbers_hash[1] = str
      @segment_hash['complete-right'] = str
    when 3
      @numbers_hash[7] = str
    when 4
      @numbers_hash[4] = str
    when 7
      @numbers_hash[8] = str
    when 5
      size5 << str
    when 6
      size6 << str
    end
  end

  # Segment Step 1: Identify top segment
  top = @segment_hash['top'] = (@numbers_hash[7].split('') - @numbers_hash[1].split('')).join

  four_plus_top_segment = (@numbers_hash[4] + top).chars.sort

  # Translator Step 1: Create number 9 (number 4 + 'top')
  size6.each do |digit|
    match = false
    four_plus_top_segment.each do |char|
      match = digit.include?(char)
      break if match == false
    end

    if match
      @numbers_hash[9] = digit

      # Segmenet Step 2: Identify bottom segment, AFTER identifying number 9
      @segment_hash['bottom'] = (digit.chars - four_plus_top_segment)[0]
      size6.delete(digit)
      break
    end
  end

  # Segment Step 3: Identify bottom left segment, which is the only missing segment in number 9
  @segment_hash['bottom-left'] = (@numbers_hash[8].chars - @numbers_hash[9].chars).join

  # Translator Step 2: Creating number 6 (only size 6 number without complete right segment)
  size6.each do |digit|
    match = false
    missing_segment = ''

    @segment_hash['complete-right'].chars.each do |char|
      match = digit.include?(char)
      if match == false
        missing_segment = char
        break
      end
    end

    if match == false
      @numbers_hash[6] = size6.delete(digit)

      # Segment Step 4 & 5: By identifying number 6, we can infer the top right segment by seeing which segment
      # is missing from the complete right segment, the other presemtn segment will be the bottom right segment
      @segment_hash['top-right'] = missing_segment
      @segment_hash['bottom-right'] = (@segment_hash['complete-right'].chars - @segment_hash['top-right'].chars).join
    end
  end

  # Translator Step 3: Last remaining size6 digit will be 0
  @numbers_hash[0] = size6.delete_at(0)

  # Segment Step 6: Missing segment from 0 is the middle segment
  @segment_hash['middle'] = (@numbers_hash[8].chars - @numbers_hash[0].chars).join

  # Segment Step 7: Last missing segment from hash is the top left segment
  @segment_hash['top-left'] = (
    @numbers_hash[8].chars -
    (@segment_hash['complete-right'] +
      @segment_hash['top'] +
      @segment_hash['bottom'] +
      @segment_hash['middle'] +
      @segment_hash['bottom-left'])
      .chars
  ).join

  # Translator Step 4: Build out remaining numbers 2 / 3 / 5
  @numbers_hash[2] = (@numbers_hash[8].chars - @segment_hash['top-left'].chars - @segment_hash['bottom-right'].chars).join
  @numbers_hash[3] = (@numbers_hash[8].chars - @segment_hash['top-left'].chars - @segment_hash['bottom-left'].chars).join
  @numbers_hash[5] = (@numbers_hash[8].chars - @segment_hash['top-right'].chars - @segment_hash['bottom-left'].chars).join
end

def output_decoder(output_array)
  number = ''

  output_array.each do |output_digit|
    number += @numbers_hash.key(output_digit).to_s
  end

  @sum += number.to_i
end

start_time = Time.now

File.open('q8input.txt', 'r') do |f|
  f.each_line do |line|
    line.chomp!

    # Step 1: Seperate both the output and input into two different arrays
    seperator(line)

    # Step 2: Run the method to generate the segment hash and numbers hash
    constructor(@input_array)

    # Step 3: Output decoder will decode the 4 digit output and add to sum
    output_decoder(@output_array)
  end
end

p @sum
