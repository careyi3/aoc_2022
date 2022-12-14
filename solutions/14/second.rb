# frozen_string_literal: true

module Day14
  module Part2
    def self.run(path, input_type)
      floor =
        if input_type == 'sample'
          9 + 2
        else
          160 + 2
        end
      map = Array.new(800) { Array.new(800) { '.' } }
      FileReader.for_each_line(path) do |line|
        rock_path = line.split(' -> ').map { |x| x.split(',').map(&:to_i) }
        rock_path.each_with_index do |coords, idx|
          next if rock_path[idx + 1].nil?

          x1 = coords[0]
          y1 = coords[1]
          x2 = rock_path[idx + 1][0]
          y2 = rock_path[idx + 1][1]
          if x1 == x2
            (y1, y2 = y2, y1) if y1 > y2
            (y1..y2).each do |y|
              map[y][x1] = '#'
            end
          end
          next unless y1 == y2

          (x1, x2 = x2, x1) if x1 > x2
          (x1..x2).each do |x|
            map[y1][x] = '#'
          end
        end
      end
      map[0][500] = '+'

      800.times do |num|
        map[floor][num] = '#'
      end

      100_000.times do |num|
        x, y = fall(map, 500, 0, input_type == 'sample')
        if x == 500 && y.zero?
          puts num + 1
          break
        end
      end
    end

    def self.fall(map, x, y, vis)
      print(map) if vis
      return [nil, nil] if x >= 799 || y >= 799

      if map[y + 1][x] == '.'
        map[y][x] = '.'
        map[y + 1][x] = '+'
        return fall(map, x, y + 1, vis)
      end

      if map[y + 1][x - 1] == '.'
        map[y][x] = '.'
        map[y + 1][x - 1] = '+'
        return fall(map, x - 1, y + 1, vis)
      end

      return [x, y] unless map[y + 1][x + 1] == '.'

      map[y][x] = '.'
      map[y + 1][x + 1] = '+'
      fall(map, x + 1, y + 1, vis)
    end

    def self.print(grid)
      Visualisation.print_grid(grid, centre_x: 6, centre_y: 500, x_dim: 12, y_dim: 23, sleep: 0.02, colour_char: '+', colour: :yellow)
    end
  end
end
