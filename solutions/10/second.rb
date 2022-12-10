# frozen_string_literal: true

module Day10
  module Part2
    def self.run(path, _)
      x = 1
      count = 1
      output_idx = 40
      crt = Array.new(6) { Array.new(40, '.') }
      vidx = 0
      FileReader.for_each_line(path) do |line|
        command, val = line.split
        if count == output_idx
          vidx += 1
          output_idx += 40
        end

        unless command == 'noop'
          count += 1
          crt[vidx][(count-1) % 40] = '#' if [x - 1, x, x + 1].include?((count-1) % 40)
          if count == output_idx
            vidx += 1
            output_idx += 40
          end
          x += val.to_i
        end
        count += 1
        crt[vidx][(count-1) % 40] = '#' if [x - 1, x, x + 1].include?((count-1) % 40)
      end
      print(crt)
    end

    def self.print(grid)
      grid.each do |line|
        puts line.join
      end
      ''
    end
  end
end
