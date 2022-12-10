# frozen_string_literal: true

module Day10
  module Part1
    def self.run(path, _)
      x = 1
      count = 1
      output_idx = 20
      outputs = []
      FileReader.for_each_line(path) do |line|
        command, val = line.split
        if count == output_idx
          outputs << (x * output_idx)
          output_idx += 40
        end

        unless command == 'noop'
          count += 1
          if count == output_idx
            outputs << (x * output_idx)
            output_idx += 40
          end
          x += val.to_i
        end
        count += 1
      end
      puts outputs.sum
    end
  end
end
