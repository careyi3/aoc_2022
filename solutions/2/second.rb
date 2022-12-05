# frozen_string_literal: true

module Day2
  module Part2
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

    PLAYS = {
      'A X' => 'Z',
      'A Y' => 'X',
      'A Z' => 'Y',
      'B X' => 'X',
      'B Y' => 'Y',
      'B Z' => 'Z',
      'C X' => 'Y',
      'C Y' => 'Z',
      'C Z' => 'X'
    }.freeze

    def self.run(path, _)
      sum = 0

      FileReader.for_each_line(path) do |line|
        opponent = line.split[0]
        me = PLAYS[line]
        play = "#{opponent} #{me}"
        sum += SCORES[play]
      end

      puts sum
    end
  end
end
