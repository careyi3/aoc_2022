# frozen_string_literal: true

module Day4
  module Part1
    def self.run(path, _)
      count = 0
      FileReader.for_each_line(path) do |line|
        input = line.split(',').map { |x| x.split('-') }
        section1 = *(input[0][0]..input[0][1])
        section2 = *(input[1][0]..input[1][1])
        intersection = section1.intersection(section2)
        count += 1 if intersection == section1 || intersection == section2
      end
      puts count
    end
  end
end
