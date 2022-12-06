# frozen_string_literal: true

module Day6
  module Part1
    def self.run(path, _)
      chars = FileReader.read_file(path).chars
      seq = []
      chars.each_with_index do |char, idx|
        seq.shift if seq.size == 4
        seq << char
        if seq.size == 4 && seq.uniq == seq
          puts idx + 1
          break
        end
      end
    end
  end
end
