# frozen_string_literal: true

module Day2
  module Part1
    SCORES = {
      'A X' => 3 + 1,
      'B X' => 0 + 1,
      'C X' => 6 + 1,
      'A Y' => 6 + 2,
      'B Y' => 3 + 2,
      'C Y' => 0 + 2,
      'A Z' => 0 + 3,
      'B Z' => 6 + 3,
      'C Z' => 3 + 3
    }.freeze

    def self.run(path, _)
      sum = 0

      FileReader.for_each_line(path) do |line|
        sum += SCORES[line]
      end

      puts sum
    end
  end
end
