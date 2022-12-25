# frozen_string_literal: true

module Day23
  module Part1
    def self.run(path, input_type)
      start_dim =
        if input_type == 'sample'
          7
        else
          72
        end
      grid = Array.new(100) { Array.new(100) { '.' } }
      idx = 50 - start_dim
      FileReader.for_each_line(path) do |line|
        chars = line.chars
        grid[idx][(grid[idx].size / 2) - (start_dim / 2), start_dim] = chars
        idx += 1
      end

      print(grid)

      elves = {}
      grid.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          elves["#{y}:#{x}"] = { consider: [0, 1, 2, 3] } if cell == '#'
        end
      end

      10.times do
        proposed_moves = {}
        elves.each do |key, val|
          y, x = key.split(':').map(&:to_i)
          next if adjacent_free?(grid, x, y)

          new_x = nil
          new_y = nil
          4.times do |dir_idx|
            dir = val[:consider][dir_idx]
            next unless can_move?(grid, x, y, dir)

            new_y, new_x = new_position(x, y, dir)
            break
          end
          dir = val[:consider].shift
          val[:consider] << dir
          next if new_y.nil? && new_x.nil?

          proposed_moves["#{new_y}:#{new_x}"] =
            if proposed_moves["#{new_y}:#{new_x}"].nil?
              proposed_moves["#{new_y}:#{new_x}"] = [[y, x]]
            else
              proposed_moves["#{new_y}:#{new_x}"] << [y, x]
            end
        end
        proposed_moves.each do |key, val|
          next if val.size > 1

          from_y, from_x = val.first
          to_y, to_x = key.split(':').map(&:to_i)
          grid[from_y][from_x] = '.'
          grid[to_y][to_x] = '#'
          elf = elves["#{from_y}:#{from_x}"]
          elves.delete("#{from_y}:#{from_x}")
          elves["#{to_y}:#{to_x}"] = elf
        end
        print(grid)
      end
      print(grid)
      ys = elves.keys.map { |x| x.split(':').first.to_i }
      xs = elves.keys.map { |x| x.split(':')[1].to_i }
      x_max = xs.max
      x_min = xs.min
      y_max = ys.max
      y_min = ys.min
      puts (((x_max - x_min) + 1) * ((y_max - y_min) + 1)) - elves.size
    end

    def self.new_position(x, y, dir)
      case dir
      when 0
        [y - 1, x]
      when 1
        [y + 1, x]
      when 2
        [y, x - 1]
      when 3
        [y, x + 1]
      end
    end

    def self.adjacent_free?(grid, x, y)
      adjacents = [grid[y][x + 1], grid[y + 1][x], grid[y][x - 1], grid[y - 1][x], grid[y + 1][x + 1], grid[y - 1][x - 1], grid[y + 1][x - 1], grid[y - 1][x + 1]]
      adjacents.uniq.size == 1 && adjacents.first == '.'
    end

    def self.can_move?(grid, x, y, dir)
      case dir
      when 0
        adjacents = [grid[y - 1][x - 1], grid[y - 1][x], grid[y - 1][x + 1]]
      when 1
        adjacents = [grid[y + 1][x - 1], grid[y + 1][x], grid[y + 1][x + 1]]
      when 2
        adjacents = [grid[y - 1][x - 1], grid[y][x - 1], grid[y + 1][x - 1]]
      when 3
        adjacents = [grid[y + 1][x + 1], grid[y][x + 1], grid[y - 1][x + 1]]
      end
      adjacents.uniq.size == 1 && adjacents.first == '.'
    end

    def self.print(grid)
      Visualisation.print_grid(grid, centre_x: 50, centre_y: 50, x_dim: 30, y_dim: 30, empty_char: '.', sleep: 0.1)
    end
  end
end
