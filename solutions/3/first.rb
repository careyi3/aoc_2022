# frozen_string_literal: true

module Day3
  module Part1
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

    def self.run(path)
      backpacks = {}
      idx = 0
      FileReader.for_each_line(path) do |line|
        contents = line.chars
        pocket1, pocket2 = contents.each_slice((contents.size / 2.0).round).to_a
        common = pocket1.intersection(pocket2)

        sum = 0
        common.each do |item|
          sum +=
            if /[[:upper:]]/.match(item)
              LOOKUP[item.downcase] + 26
            else
              LOOKUP[item]
            end
        end

        backpacks[idx] = sum
        idx += 1
      end

      puts backpacks.values.sum
    end
  end
end
