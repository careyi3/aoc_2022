# frozen_string_literal: true

module Day18
  module Part1
    def self.run(path, _)
      cubes = []
      FileReader.for_each_line(path) do |line|
        x, y, z = line.split(',').map(&:to_i)
        cubes << { x:, y:, z:, exposed: 6 }
      end
      cubes.each_with_index do |current, cidx|
        non_unique_faces = []
        cubes.each do |target, tidx|
          next if cidx == tidx

          non_unique_faces << [target[:x], target[:y], target[:z]] if (current[:x] == target[:x] && current[:y] == target[:y]) && (current[:z] == target[:z] + 1 || current[:z] == target[:z] - 1)

          non_unique_faces << [target[:x], target[:y], target[:z]] if (current[:x] == target[:x] && current[:z] == target[:z]) && (current[:y] == target[:y] + 1 || current[:y] == target[:y] - 1)

          non_unique_faces << [target[:x], target[:y], target[:z]] if (current[:z] == target[:z] && current[:y] == target[:y]) && (current[:x] == target[:x] + 1 || current[:x] == target[:x] - 1)
        end
        current[:exposed] = current[:exposed] - non_unique_faces.uniq.count
      end
      puts cubes.map { |x| x[:exposed] }.sum
    end
  end
end
