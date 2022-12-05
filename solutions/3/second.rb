# frozen_string_literal: true

module Day3
  module Part2
    LOOKUP = {
      'a' => 1,
      'b' => 2,
      'c' => 3,
      'd' => 4,
      'e' => 5,
      'f' => 6,
      'g' => 7,
      'h' => 8,
      'i' => 9,
      'j' => 10,
      'k' => 11,
      'l' => 12,
      'm' => 13,
      'n' => 14,
      'o' => 15,
      'p' => 16,
      'q' => 17,
      'r' => 18,
      's' => 19,
      't' => 20,
      'u' => 21,
      'v' => 22,
      'w' => 23,
      'x' => 24,
      'y' => 25,
      'z' => 26
    }.freeze

    def self.run(path, _)
      group = {}
      idx = 0
      count = 1
      last_content = nil
      FileReader.for_each_line(path) do |line|
        if last_content.nil?
          last_content = line.chars
          count += 1
          next
        else
          last_content = last_content.intersection(line.chars)
        end

        if (count % 3).zero?
          value =
            if /[[:upper:]]/.match(last_content[0])
              LOOKUP[last_content[0].downcase] + 26
            else
              LOOKUP[last_content[0]]
            end

          group[idx] = value
          idx += 1
          last_content = nil
        end
        count += 1
      end
      puts group.values.sum
    end
  end
end
