# frozen_string_literal: true

module Day8
  module Part1
    def self.run(path, _)
      grid = []
      other_grid = []
      FileReader.for_each_line(path) do |line|
        xs = line.chars.map(&:to_i)
        grid << xs
        xs.each_with_index do |x, idx|
          if other_grid[idx].nil?
            other_grid[idx] = [x]
          else
            other_grid[idx] << x
          end
        end
      end
      width = grid[0].size
      height = grid.size
      count = 0
      (1..width - 2).each do |x|
        (1..height - 2).each do |y|
          left = grid[x][0, y].max
          right = grid[x][y + 1, width].max
          up = other_grid[y][0, x].max
          down = other_grid[y][x + 1, height].max
          next unless grid[x][y] > left ||
                      grid[x][y] > right ||
                      grid[x][y] > up ||
                      grid[x][y] > down

          count += 1
        end
      end
      puts count + (2 * width) + (2 * (height - 2))
    end
  end
end
