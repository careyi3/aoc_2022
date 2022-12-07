# frozen_string_literal: true

module Day7
  module Part2
    def self.run(path, _)
      file_system = { '/' => { 'name' => '/', 'size' => 0 } }
      stack = [file_system['/']]
      dirs = {}
      FileReader.for_each_line(path) do |line|
        input = line.split
        if input[0] == '$'
          next if input[1] == 'ls'

          if input[2] == '..'
            size = 0
            stack.last.each do |key, val|
              next if %w[size name].include?(key)

              size +=
                if val.is_a?(Hash)
                  val['size']
                else
                  val
                end
            end
            stack.last['size'] = size
            if stack.size < 2
              dirs[stack.last['name']] = size
            else
              dirs["#{stack[-2]['name']}/#{stack.last['name']}"] = size
            end
            stack.pop
          else
            stack << stack.last[input[2]]
          end
        else
          stack.last[input[1]] =
            if input[0] == 'dir'
              { 'name' => input[1], 'size' => 0 }
            else
              input[0].to_i
            end
        end
      end
      space_needed = 30_000_000 - (70_000_000 - dirs['/'])
      puts dirs.values.select { |x| x >= space_needed }.min
    end
  end
end
