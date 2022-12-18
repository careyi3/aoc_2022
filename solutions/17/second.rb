# frozen_string_literal: true

module Day17
  module Part2
    ROCKS = {
      1 => {
        points: [
          ->(x, y) { [y, x] },
          ->(x, y) { [y, x + 1] },
          ->(x, y) { [y, x + 2] },
          ->(x, y) { [y, x + 3] }
        ],
        width: 4,
        height: 1
      },
      2 => {
        points: [
          ->(x, y) { [y, x + 1] },
          ->(x, y) { [y + 1, x] },
          ->(x, y) { [y + 1, x + 1] },
          ->(x, y) { [y + 1, x + 2] },
          ->(x, y) { [y + 2, x + 1] }
        ],
        width: 3,
        height: 3
      },
      3 => {
        points: [
          ->(x, y) { [y, x] },
          ->(x, y) { [y, x + 1] },
          ->(x, y) { [y, x + 2] },
          ->(x, y) { [y + 1, x + 2] },
          ->(x, y) { [y + 2, x + 2] }
        ],
        width: 3,
        height: 3
      },
      4 => {
        points: [
          ->(x, y) { [y, x] },
          ->(x, y) { [y + 1, x] },
          ->(x, y) { [y + 2, x] },
          ->(x, y) { [y + 3, x] }
        ],
        width: 1,
        height: 4
      },
      5 => {
        points: [
          ->(x, y) { [y, x] },
          ->(x, y) { [y, x + 1] },
          ->(x, y) { [y + 1, x] },
          ->(x, y) { [y + 1, x + 1] }
        ],
        width: 2,
        height: 2
      }
    }.freeze

    WINDOW_SIZE = 100
    WINDOW_ADJUSTMENT = 10
    LOOP_COUNT = 4000

    def self.run(path, _)
      jets = FileReader.read_file(path).chars.map { |x| x == '>' ? 1 : -1 }
      grid = Array.new(WINDOW_SIZE + WINDOW_ADJUSTMENT) { Array.new(7) { '+' } }
      sum_biggest_height = 0
      last_biggest_height = 0
      biggest_height = 0
      count = 1
      moves = 0
      cache = {}
      while count < LOOP_COUNT
        rock_type = (count % 5).zero? ? 5 : count % 5
        at_rest = false
        x = 2
        if biggest_height >= WINDOW_SIZE
          sum_biggest_height += (biggest_height - last_biggest_height)
          biggest_height -= WINDOW_ADJUSTMENT
          last_biggest_height = biggest_height
          10.times { grid << Array.new(7) { '+' } }
          10.times { grid.shift }
        end
        y = biggest_height + 3
        until at_rest
          rock_points = get_grid_points(x, y, rock_type)
          rock_points.each do |rock_point|
            grid[rock_point[0]][rock_point[1]] = '#'
          end
          print(grid, biggest_height)

          # move left or right
          new_x = x + (moves.zero? ? jets[0] : jets[moves % jets.size])
          check = !new_x.negative? && (new_x + ROCKS[rock_type][:width]) <= 7
          move = true
          if check
            lr_rock_points = get_grid_points(new_x, y, rock_type)
            (lr_rock_points - rock_points).each do |rock_point|
              next unless move

              move = false if grid[rock_point[0]][rock_point[1]] == '#'
            end
            if move
              x = new_x
              rock_points.each do |rock_point|
                grid[rock_point[0]][rock_point[1]] = '+'
              end
              rock_points = lr_rock_points
              rock_points.each do |rock_point|
                grid[rock_point[0]][rock_point[1]] = '#'
              end
              print(grid, biggest_height)
            end
          end

          # move down
          new_y = y - 1
          move = true
          if new_y.negative?
            biggest_height = y + ROCKS[rock_type][:height] if y + ROCKS[rock_type][:height] > biggest_height
            move = false
            at_rest = true
            moves += 1
            break
          end
          d_rock_points = get_grid_points(x, new_y, rock_type)
          (d_rock_points - rock_points).each do |rock_point|
            next unless move

            move = false if grid[rock_point[0]][rock_point[1]] == '#'
          end
          if move
            y = new_y
            rock_points.each do |rock_point|
              grid[rock_point[0]][rock_point[1]] = '+'
            end
            rock_points = d_rock_points
            rock_points.each do |rock_point|
              grid[rock_point[0]][rock_point[1]] = '#'
            end
            print(grid, biggest_height)
          else
            at_rest = true
          end

          if at_rest
            biggest_height = y + ROCKS[rock_type][:height] if y + ROCKS[rock_type][:height] > biggest_height
          end

          moves += 1
        end
        jets_cache_key = moves.zero? ? 0 : moves % jets.size
        heights = Array.new(7) { '.' }
        grid.reverse.each_with_index do |row, depth|
          row.each_with_index do |cell, idx|
            next unless heights[idx] == '.'

            if cell == '#'
              heights[idx] = biggest_height - (grid.size - depth)
            end
          end
        end
        cache_key = "#{jets_cache_key}:#{rock_type}:#{heights.join(':')}"
        cache[cache_key] =
          if cache[cache_key].nil?
            [count, sum_biggest_height + (biggest_height - last_biggest_height)]
          else
            cache[cache_key] << [count, sum_biggest_height + (biggest_height - last_biggest_height)]
          end

        if count == LOOP_COUNT - 1
          sum_biggest_height += (biggest_height - last_biggest_height)
        end
        count += 1
      end
      puts sum_biggest_height
      #197 313
      #1942 3066
      #3687 5819

      # initial_steps = 197
      # initial_height = 313
      # height = initial_height
      # cycle_length = 1745
      # cycle_hight = 2753
      # full_loops = (1000000000000 - 197)/cycle_length
      # height += full_loops * cycle_hight
      # remainder_cycles = (1000000000000 - 197)%cycle_length
      # remainder_cycles_height = 1629
      # height += (remainder_cycles_height - initial_height)
      binding.pry
    end

    def self.get_grid_points(x, y, rock_type)
      points = []
      ROCKS[rock_type][:points].each do |point|
        points << point.call(x, y)
      end
      points
    end

    def self.print(grid, y)
      #Visualisation.print_grid(grid, centre_x: 20, centre_y: 4, x_dim: 40, y_dim: 8, sleep: 0.1, spacer: ' ', colour_char: '#', colour: :red, flip: true)
    end
  end
end
