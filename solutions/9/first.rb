# frozen_string_literal: true

module Day9
  module Part1
    def self.run(path, sample)
      grid_size =
        if sample == 'sample'
          40
        else
          800
        end
      visited = { "#{grid_size / 2}:#{grid_size / 2}" => 1 }
      grid = Array.new(grid_size) { Array.new(grid_size) }
      head_x = grid_size / 2
      head_y = grid_size / 2
      tail_x = grid_size / 2
      tail_y = grid_size / 2
      FileReader.for_each_line(path) do |line|
        dir, dist = line.split
        (1..dist.to_i).each do
          grid[head_x][head_y] = visited["#{head_x}:#{head_y}"].nil? ? '.' : '#'
          grid[tail_x][tail_y] = '#'
          case dir
          when 'L'
            head_x -= 1
          when 'R'
            head_x += 1
          when 'U'
            head_y += 1
          when 'D'
            head_y -= 1
          end
          tail_x, tail_y = update_tail(head_x, head_y, tail_x, tail_y)
          grid[tail_x][tail_y] = 'T'
          grid[head_x][head_y] = 'H'

          Visualisation.print_grid(grid, centre_x: tail_x, centre_y: tail_y, sleep: 0.01)

          visited["#{tail_x}:#{tail_y}"] =
            if visited["#{tail_x}:#{tail_y}"].nil?
              1
            else
              visited["#{tail_x}:#{tail_y}"] + 1
            end
        end
      end
      puts visited.keys.size
    end

    def self.update_tail(head_x, head_y, tail_x, tail_y)
      dist = (head_x - tail_x).abs + (head_y - tail_y).abs
      slope = (head_y - tail_y).to_f / (head_x - tail_x)
      return tail_x, tail_y unless dist > 1 && (!slope.zero? || slope != 1.0/0.0 || slope != 1.0/0.0)

      if slope.zero?
        if head_x > tail_x
          tail_x += 1
        else
          tail_x -= 1
        end
      end

      tail_y += 1 if slope == 1.0/0.0
      tail_y -= 1 if slope == -1.0/0.0

      if [2, 0.5].include?(slope)
        if tail_x < head_x
          tail_x += 1
          tail_y += 1
        else
          tail_x -= 1
          tail_y -= 1
        end
      end

      if [-2, -0.5].include?(slope)
        if tail_x < head_x
          tail_x += 1
          tail_y -= 1
        else
          tail_x -= 1
          tail_y += 1
        end
      end

      [tail_x, tail_y]
    end
  end
end
