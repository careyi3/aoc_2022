# frozen_string_literal: true

module Day15
  module Part2
    def self.run(path, input_type)
      max_coord =
        if input_type == 'sample'
          20
        else
          4_000_000
        end
      sensors = []
      beacon_ys = {}
      FileReader.for_each_line(path) do |line|
        data = line.split('=')
        sx = data[1].split(',').first.to_i
        sy = data[2].split(':').first.to_i
        bx = data[3].split(',').first.to_i
        by = data[4].to_i
        beacon_ys[by] = bx
        sensors << { sx:, sy:, dist: (sx - bx).abs + (sy - by).abs }
      end

      ranges = []
      sensors.each do |sensor|
        next if sensor[:sx].negative? || sensor[:sy].negative? || sensor[:sx] > max_coord || sensor[:sy] > max_coord

        from = sensor[:sy] - sensor[:dist]
        to = sensor[:sy] + sensor[:dist]
        from = (from.negative? ? 0 : from)
        to = (to > max_coord ? max_coord : to)

        ranges << [from, to]
      end

      x = nil
      y = nil
      max_coord.times do |target_y|
        detected_points = []
        sensors.each do |sensor|
          next if (sensor[:sy] - target_y).abs > sensor[:dist]

          remainder = sensor[:dist] - (sensor[:sy] - target_y).abs
          from = sensor[:sx] - remainder
          to = sensor[:sx] + remainder
          detected_points << [from.negative? ? 0 : from, to > max_coord ? max_coord : to]
        end

        count_at2 = 0
        while detected_points.size > 1
          new_ranges = []
          detected_points.each_with_index do |r, idx|
            next if detected_points[idx + 1].nil?

            f1 = r[0]
            f2 = detected_points[idx + 1][0]
            t1 = r[1]
            t2 = detected_points[idx + 1][1]

            if t2 > f1 && f2 > f1
              new_ranges << [f1, t1]
              new_ranges.unshift([f2, t2])
              next
            end

            if f1 > f2 && f1 > t2
              new_ranges << [f1, t1]
              new_ranges.unshift([f2, t2])
              next
            end

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
          detected_points = new_ranges.uniq.shuffle
          if count_at2 > 50
            y = target_y
            x = detected_points.flatten.sort[1] + 1
            break
          end
          count_at2 += 1 if detected_points.size == 2
        end

        break unless y.nil? && x.nil?
      end

      puts (x * 4_000_000) + y
    end
  end
end
