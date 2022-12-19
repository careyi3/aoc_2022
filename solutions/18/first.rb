# frozen_string_literal: true

module Day18
  module Part1
    def self.run(path, _)
      cubes = {}
      FileReader.for_each_line(path) do |line|
        x, y, z = line.split(',').map(&:to_i)
        cubes["#{x}:#{y}:#{z}"] = { x:, y:, z:, exposed: 0 }
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
      end
      puts cubes.values.map { |x| x[:exposed] }.sum
    end
  end
end
