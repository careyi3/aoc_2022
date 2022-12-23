# frozen_string_literal: true

module Day21
  module Part2
    def self.run(path, _)
      monkeys = {}
      FileReader.for_each_line(path) do |line|
        key, val = line.split(': ')
        next if key == 'humn'

        monkeys[key] =
          if val.to_i.zero?
            x, op, y = val.split
            -> { eval("monkeys['#{x}'].call #{op} monkeys['#{y}'].call", binding, __FILE__, __LINE__) }
          else
            -> { val.to_i }
          end
      end

      num = 3_555_555_555_555
      Kernel.loop do
        monkeys['humn'] = -> { num }
        diff = monkeys['pnhm'].call - 32_853_424_641_061
        if diff.zero?
          puts num
          break
        end
        modifier = diff > 1000 ? diff / 1000 : 1
        if diff.positive?
          num += modifier
        else
          num -= modifier
        end
      end
    end
  end
end
