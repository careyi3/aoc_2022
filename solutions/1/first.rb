# frozen_string_literal: true

module Day1
  module Part1
    def self.run(path)
      elves = {}
      elf_count = 0
      elf_most_cals = 0
      most_cals = 0

      FileReader.for_each_line(path) do |line|
        if line == ''
          if elves[elf_count] > most_cals
            most_cals = elves[elf_count]
            elf_most_cals = elf_count
          end
          elf_count += 1
        else
          elves[elf_count] =
            if elves[elf_count].nil?
              line.to_i
            else
              elves[elf_count] + line.to_i
            end
        end
      end

      puts most_cals
    end
  end
end
