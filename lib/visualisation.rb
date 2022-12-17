# frozen_string_literal: true

require('colorized_string')

module Visualisation
  def self.print_grid(grid, centre_x: 20, centre_y: 20, x_dim: 40, y_dim: 40, sleep: 0.01, spacer: ' ', colour_char: nil, colour: nil, flip: false)
    system('clear')
    x_origin = centre_x - (x_dim / 2) >= 0 ? centre_x - (x_dim / 2) : 0
    y_origin = centre_y - (y_dim / 2) >= 0 ? centre_y - (y_dim / 2) : 0
    if flip
      (x_origin + x_dim - 1).downto(x_origin).each do |x|
        (y_origin..y_origin + y_dim - 1).each do |y|
          grid_x = grid[x]
          val = grid[x].nil? ? nil : grid_x[y]
          val ||= '.'
          print_and_flush("#{val}#{spacer}", colour_char, colour)
        end
        puts ''.black
      end
    else
      (x_origin..x_origin + x_dim - 1).each do |x|
        (y_origin..y_origin + y_dim - 1).each do |y|
          grid_x = grid[x]
          val = grid[x].nil? ? nil : grid_x[y]
          val ||= '.'
          print_and_flush("#{val}#{spacer}", colour_char, colour)
        end
        puts ''.black
      end
    end
    sleep(sleep)
  end

  def self.print_and_flush(str, colour_char, colour)
    str = ColorizedString[str].colorize(colour) if str[0] == colour_char
    print(str)
    $stdout.flush
  end
end
