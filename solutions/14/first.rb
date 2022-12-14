# frozen_string_literal: true

module Day14
  module Part1
    def self.run(path, _)
      map = Array.new(600) { Array.new(600) { '.' } }
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
      largest_y = 0
      2000.times do |num|
        _, y = fall(map, 500, 0)
        if y.nil?
          puts "Steps: #{num}"
          break
        elsif y > largest_y
          largest_y = y
        end
      end
      puts "Largest Y: #{largest_y + 1}"
    end

    def self.fall(map, x, y)
      # print(map, y, x)
      return [nil, nil] if x >= 599 || y >= 599

      if map[y + 1][x] == '.'
        map[y][x] = '.'
        map[y + 1][x] = '+'
        return fall(map, x, y + 1)
      end

      if map[y + 1][x - 1] == '.'
        map[y][x] = '.'
        map[y + 1][x - 1] = '+'
        return fall(map, x - 1, y + 1)
      end

      return [x, y] unless map[y + 1][x + 1] == '.'

      map[y][x] = '.'
      map[y + 1][x + 1] = '+'
      fall(map, x + 1, y + 1)
    end

    def self.print(grid, x, y)
      Visualisation.print_grid(grid, centre_x: x, centre_y: y, x_dim: 60, y_dim: 60, sleep: 0.001)
    end
  end
end
