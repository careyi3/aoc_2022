# frozen_string_literal: true

module Visualisation
  def self.print_grid(grid, centre_x: 20, centre_y: 20, x_dim: 40, y_dim: 40, sleep: 0.01)
    system('clear')
    x_origin = centre_x - (x_dim / 2) >= 0 ? centre_x - (x_dim / 2) : 0
    y_origin = centre_y - (y_dim / 2) >= 0 ? centre_y - (y_dim / 2) : 0
    (x_origin..x_origin + x_dim - 1).each do |x|
      ys = []
      (y_origin..y_origin + y_dim - 1).each do |y|
        grid_x = grid[x]
        ys << (grid[x].nil? ? nil : grid_x[y])
      end
      puts ys.map { |c| c || '.' }.join(' ')
    end
    sleep(sleep)
  end
end
