# frozen_string_literal: true

module Day16
  module Part2
    def self.run(path, _)
      map = {}
      FileReader.for_each_line(path) do |line|
        data = line.split
        map[data[1]] = {
          flow: data[4].split('=')[1].split(';')[0].to_i,
          paths: data[9..].map { |x| x.gsub(',', '') }
        }
      end
      paths = walk(map, {}, ['AA'], ['AA'], 0, 0, 0)
      puts paths.values.max
    end

    def self.walk(map, paths, me_path, elephant_path, released, releasing, time)
      released += releasing
      if time == 25
        paths["#{me_path.join}:#{elephant_path}:#{time}"] = released
        return paths
      end

      paths["#{me_path.join}:#{elephant_path}:#{time}"] = released

      map[path.last][:paths].each do |v|
        next if v == path[-2] && map[path.last][:paths].size > 1

        added_time = 1
        added_releasing = 0
        if paths["#{[path, v].flatten.join}:#{time + added_time}"].nil?
          paths = walk(map, paths, [path, v].flatten, released, releasing + added_releasing, time + added_time)
        end

        if map[v][:flow].positive? && !path.include?(v)
          added_releasing = map[v][:flow]
          added_time = 2
          released += releasing
          if time + 1 == 25
            paths["#{path.join}:#{time + 1}"] = released
            return paths
          end
        end

        if paths["#{[path, v].flatten.join}:#{time + added_time}"].nil?
          paths = walk(map, paths, [path, v].flatten, released, releasing + added_releasing, time + added_time)
        end
      end

      paths
    end
  end
end
