# frozen_string_literal: true

module Day15
  module Part1
    def self.run(path, input_type)
      target_y =
        if input_type == 'sample'
          10
        else
          2_000_000
        end
      sensors = []
      FileReader.for_each_line(path) do |line|
        data = line.split('=')
        sx = data[1].split(',').first.to_i
        sy = data[2].split(':').first.to_i
        bx = data[3].split(',').first.to_i
        by = data[4].to_i
        sensors << { sx:, sy:, dist: (sx - bx).abs + (sy - by).abs }
      end
      detected_points = []
      sensors.each do |sensor|
        next if (sensor[:sy] - target_y).abs > sensor[:dist]

        remainder = sensor[:dist] - (sensor[:sy] - target_y).abs
        f = sensor[:sx] - remainder
        t = sensor[:sx] + remainder
        detected_points << [f, t]
      end

      while detected_points.size > 1
        new_ranges = []
        detected_points.each_with_index do |r, idx|
          next if detected_points[idx + 1].nil?

          f1 = r[0]
          f2 = detected_points[idx + 1][0]
          t1 = r[1]
          t2 = detected_points[idx + 1][1]

          if t1 >= t2 && f1 >= f2
            new_ranges << [f2, t1]
            next
          end
          if f1 <= f2 && t1 >= t2
            new_ranges << [f1, t1]
            next
          end
          if f2 <= f1 && t2 >= t1
            new_ranges << [f2, t2]
            next
          end
          if t1 >= f2 && t2 > f1
            new_ranges << [f1, t2]
            next
          end
          if t1 >= t2 && f2 <= f1
            new_ranges << [f2, t1]
            next
          end
        end
        detected_points = new_ranges
      end
      puts detected_points.first[1] - detected_points.first[0]
    end
  end
end
