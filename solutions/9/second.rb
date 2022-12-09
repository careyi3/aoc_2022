# frozen_string_literal: true

module Day9
  module Part2
    def self.run(path, sample)
      grid_size =
        if sample == 'sample'
          50
        else
          800
        end
      visited = { "#{grid_size / 2}:#{grid_size / 2}" => 1 }
      grid = Array.new(grid_size) { Array.new(grid_size) }
      positions = { 'H' => { x: grid_size / 2, y: grid_size / 2 } }
      (1..9).each do |num|
        positions[num.to_s] = { x: grid_size / 2, y: grid_size / 2 }
      end
      FileReader.for_each_line(path) do |line|
        dir, dist = line.split
        (1..dist.to_i).each do
          positions.each do |key, val|
            grid[val[:x]][val[:y]] =
              if key == '9'
                '#'
              else
                '.'
              end
          end

          case dir
          when 'L'
            positions['H'][:x] = positions['H'][:x] - 1
          when 'R'
            positions['H'][:x] = positions['H'][:x] + 1
          when 'U'
            positions['H'][:y] = positions['H'][:y] + 1
          when 'D'
            positions['H'][:y] = positions['H'][:y] - 1
          end

          head_x = positions['H'][:x]
          head_y = positions['H'][:y]
          (1..9).each do |num|
            head_x, head_y = update_tail(head_x, head_y, positions[num.to_s][:x], positions[num.to_s][:y])
            positions[num.to_s][:x] = head_x
            positions[num.to_s][:y] = head_y
          end

          positions.each do |key, val|
            grid[val[:x]][val[:y]] = key
          end

          visited["#{positions['9'][:x]}:#{positions['9'][:y]}"] =
            if visited["#{positions['9'][:x]}:#{positions['9'][:y]}"].nil?
              1
            else
              visited["#{positions['9'][:x]}:#{positions['9'][:y]}"] + 1
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

      if slope == 1 && dist == 4
        if tail_x < head_x
          tail_x += 1
          tail_y += 1
        else
          tail_x -= 1
          tail_y -= 1
        end
      end

      if slope == -1 && dist == 4
        if tail_x < head_x
          tail_x += 1
          tail_y -= 1
        else
          tail_x -= 1
          tail_y += 1
        end
      end

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

    def self.print(grid)
      grid.each do |line|
        puts line.map { |x| x || '.' }.join(' ')
      end
      ''
    end
  end
end
