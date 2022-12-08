# frozen_string_literal: true

module Day8
  module Part2
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
      score = 0
      (1..width - 2).each do |x|
        (1..height - 2).each do |y|
          left = grid[x][0, y].reverse
          right = grid[x][y + 1, width]
          up = other_grid[y][0, x].reverse
          down = other_grid[y][x + 1, height]
          tree_height = grid[x][y]
          dists = []
          [left, right, up, down].each_with_index do |view, vidx|
            max_idx = 0
            view.each_with_index do |tree, tidx|
              max_idx = tidx
              break if tree >= tree_height
            end
            dists[vidx] = max_idx + 1
          end
          new_score = dists.inject(:*)
          score = new_score if new_score > score
        end
      end
      puts score
    end
  end
end
