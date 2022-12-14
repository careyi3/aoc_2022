# frozen_string_literal: true

module Day12
  module Part1
    def self.run(path, _)
      map = []
      grid = []
      FileReader.for_each_line(path) do |line|
        map <<
          line.chars.map do |x|
            if %w[S E].include?(x)
              if x == 'S'
                0
              else
                27
              end
            else
              x.ord - 96
            end
          end
        grid << line.chars
      end
      start_x = 0
      start_y = 0
      end_x = 0
      end_y = 0
      map.each_with_index do |x, idx|
        x.each_with_index do |y, idy|
          if y == 27
            end_x = idx
            end_y = idy
          end
          if y == 0
            start_x = idx
            start_y = idy
          end
        end
      end
      visited = {}
      step(start_x, start_y, map, grid, 0, visited)
      puts visited["#{end_x}:#{end_y}"]
    end

    def self.step(x, y, map, grid, steps, visited)
      return visited if !visited["#{x}:#{y}"].nil? && steps >= visited["#{x}:#{y}"]

      visited["#{x}:#{y}"] = steps
      current = map[x][y]
      return visited if current == 27

      grid[x][y] = '#'
      print(grid)

      up = (y - 1 >= 0 ? map[x][y - 1] : 30)
      down = (y + 1 <= map.first.size - 1 ? map[x][y + 1] : 30)
      left = (x - 1 >= 0 ? map[x - 1][y] : 30)
      right = (x + 1 <= map.size - 1 ? map[x + 1][y] : 30)

      visited = step(x, y - 1, map, grid, steps + 1, visited) if up - current < 2 || (current == 25 && up == 27)
      visited = step(x, y + 1, map, grid, steps + 1, visited) if down - current < 2 || (current == 25 && down == 27)
      visited = step(x - 1, y, map, grid, steps + 1, visited) if left - current < 2 || (current == 25 && left == 27)
      visited = step(x + 1, y, map, grid, steps + 1, visited) if right - current < 2 || (current == 25 && right == 27)
      grid[x][y] =
        if map[x][y].zero?
          'S'
        else
          (map[x][y] + 96).chr
        end
      print(grid)
      visited
    end

    def self.print(grid)
      Visualisation.print_grid(grid, centre_x: 21, centre_y: 35, x_dim: 42, y_dim: 70, sleep: 0.01, spacer: ' ', colour_char: '#', colour: :red)
    end
  end
end
