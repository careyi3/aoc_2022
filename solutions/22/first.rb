# frozen_string_literal: true

module Day22
  module Part1
    def self.run(path, input_type)
      grid_width =
        if input_type == 'sample'
          16
        else
          150
        end
      read_instructions = false
      instructions = ''
      grid = []
      FileReader.for_each_line(path, no_strip: true) do |line|
        if line == "\n"
          read_instructions = true
          next
        end
        if read_instructions
          instructions = line.scan(/\d+|[A-Za-z]+/).map { |x| x.to_i.zero? ? x : x.to_i }
        else
          chars = line.gsub(' ', '*').gsub("\n", '').chars
          row = Array.new(grid_width) { '*' }
          row[0, chars.length] = chars
          grid << row
        end
      end
      direction = 0
      marker = '>'
      y = 0
      x = grid[y].find_index('.')
      print(grid, x, y) if input_type == 'sample'
      y_max = grid.size - 1
      x_max = grid.first.size - 1
      instructions.each do |instruction|
        if instruction.is_a?(Integer)
          instruction.times do
            case direction
            when 0
              new_x = x + 1
              new_y = y
              new_x = [grid[y].find_index('>'), grid[y].find_index('<'), grid[y].find_index('V'), grid[y].find_index('^'), grid[y].find_index('.'), grid[y].find_index('#')].compact.min if new_x > x_max || grid[new_y][new_x] == '*'
              marker = '>'
            when 1
              new_x = x
              new_y = y + 1
              vertical = grid.map { |a| a[new_x] }
              new_y = [vertical.find_index('>'), vertical.find_index('<'), vertical.find_index('V'), vertical.find_index('^'), vertical.find_index('.'), vertical.find_index('#')].compact.min if new_y > y_max || grid[new_y][new_x] == '*'
              marker = 'V'
            when 2
              new_x = x - 1
              new_y = y
              new_x = ((grid[y].size - 1) - [grid[y].reverse.find_index('>'), grid[y].reverse.find_index('<'), grid[y].reverse.find_index('V'), grid[y].reverse.find_index('^'), grid[y].reverse.find_index('.'), grid[y].reverse.find_index('#')].compact.min) if new_x.negative? || grid[new_y][new_x] == '*'
              marker = '<'
            when 3
              new_x = x
              new_y = y - 1
              vertical = grid.map { |a| a[new_x] }.reverse
              new_y = ((vertical.size - 1) - [vertical.find_index('>'), vertical.find_index('<'), vertical.find_index('V'), vertical.find_index('^'), vertical.find_index('.'), vertical.find_index('#')].compact.min) if new_y.negative? || grid[new_y][new_x] == '*'
              marker = '^'
            end
            grid[y][x] = marker
            if %w[. < > V ^].include?(grid[new_y][new_x])
              x = new_x
              y = new_y
            elsif grid[new_y][new_x] == '#'
              grid[y][x] = marker
              print(grid, x, y) if input_type == 'sample'
              next
            end
            grid[y][x] = marker
            print(grid, x, y) if input_type == 'sample'
          end
        else
          if instruction == 'R'
            direction += 1
          else
            direction -= 1
          end
          direction = 0 if direction == 4
          direction = 3 if direction == -1
        end
      end
      print(grid, x, y) if input_type == 'sample'
      col = x + 1
      row = y + 1
      puts (1000 * row) + (4 * col) + direction
    end

    def self.print(grid, x, y)
      Visualisation.print_grid(grid, centre_x: 6, centre_y: 8, x_dim: 12, y_dim: 16, empty_char: '*', sleep: 0.1)
    end
  end
end
