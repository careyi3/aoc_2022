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
          crt[vidx][(count - 1) % 40] = '#' if [x - 1, x, x + 1].include?((count - 1) % 40)
          if count == output_idx
            vidx += 1
            output_idx += 40
          end
          x += val.to_i
        end
        count += 1
        crt[vidx][(count - 1) % 40] = '#' if [x - 1, x, x + 1].include?((count - 1) % 40)
        Visualisation.print_grid(crt, centre_x: 3, centre_y: 20, x_dim: 6, y_dim: 40, sleep: 0.01)
      end
    end
  end
end
