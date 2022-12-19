# frozen_string_literal: true

module Day18
  module Part2
    def self.run(path, _)
      cubes = {}
      FileReader.for_each_line(path) do |line|
        x, y, z = line.split(',').map(&:to_i)
        cubes["#{x}:#{y}:#{z}"] = { x:, y:, z:, exposed: 0, exterior: 0 }
      end

      cubes.each do |_, current|
        x = current[:x]
        y = current[:y]
        z = current[:z]
        faces = {
          [x, y, z + 1].join(':') => { coords: [x, y, z + 1] },
          [x, y, z - 1].join(':') => { coords: [x, y, z - 1] },
          [x, y + 1, z].join(':') => { coords: [x, y + 1, z] },
          [x, y - 1, z].join(':') => { coords: [x, y - 1, z] },
          [x + 1, y, z].join(':') => { coords: [x + 1, y, z] },
          [x - 1, y, z].join(':') => { coords: [x - 1, y, z] }
        }
        exposed = []
        faces.each do |key, _|
          exposed << key if cubes[key].nil?
        end
        current[:exposed] = exposed.size

        exterior = []
        exposed.each do |key|
          x, y, z = faces[key][:coords]
          exterior << key if walk(cubes, {}, x, y, z, 0)
        end
        current[:exterior] = exterior.size
      end
      puts cubes.values.map { |x| x[:exposed] }.sum
      puts cubes.values.map { |x| x[:exterior] }.sum
    end

    def self.walk(cubes, visited, x, y, z, depth)
      depth += 1
      return false unless visited["#{x}:#{y}:#{z}"].nil?
      return true if depth == 2000
      return true if (x.negative? || x > 40) && (y.negative? || y > 40) && (z.negative? || z > 40)
      return false unless cubes["#{x}:#{y}:#{z}"].nil?

      visited["#{x}:#{y}:#{z}"] = true

      adj = [
        [x, y, z + 1],
        [x, y, z - 1],
        [x, y + 1, z],
        [x, y - 1, z],
        [x + 1, y, z],
        [x - 1, y, z]
      ]

      adj.each do |a|
        x, y, z = a
        return true if walk(cubes, visited, x, y, z, depth)
      end
      false
    end
  end
end
