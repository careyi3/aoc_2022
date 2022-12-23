# frozen_string_literal: true

module Day21
  module Part1
    def self.run(path, _)
      monkeys = {}
      FileReader.for_each_line(path) do |line|
        key, val = line.split(': ')
        monkeys[key] =
          if val.to_i.zero?
            x, op, y = val.split
            -> { eval("monkeys['#{x}'].call #{op} monkeys['#{y}'].call", binding, __FILE__, __LINE__) }
          else
            -> { val.to_i }
          end
      end
      puts monkeys['root'].call
    end
  end
end
