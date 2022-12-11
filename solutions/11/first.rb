# frozen_string_literal: true

module Day11
  module Part1
    def self.run(_, input_type)
      sample = {
        0 => {
          items: [79, 98],
          inspections: 0,
          worry_op: ->(x) { x * 19 },
          test_op: lambda { |x|
            return 2 if (x % 23).zero?

            3
          }
        },
        1 => {
          items: [54, 65, 75, 74],
          inspections: 0,
          worry_op: ->(x) { x + 6 },
          test_op: lambda { |x|
            return 2 if (x % 19).zero?

            0
          }
        },
        2 => {
          items: [79, 60, 97],
          inspections: 0,
          worry_op: ->(x) { x * x },
          test_op: lambda { |x|
            return 1 if (x % 13).zero?

            3
          }
        },
        3 => {
          items: [74],
          inspections: 0,
          worry_op: ->(x) { x + 3 },
          test_op: lambda { |x|
            return 0 if (x % 17).zero?

            1
          }
        }
      }

      input = {
        0 => {
          items: [75, 63],
          inspections: 0,
          worry_op: ->(x) { x * 3 },
          test_op: lambda { |x|
            return 7 if (x % 11).zero?

            2
          }
        },
        1 => {
          items: [65, 79, 98, 77, 56, 54, 83, 94],
          inspections: 0,
          worry_op: ->(x) { x + 3 },
          test_op: lambda { |x|
            return 2 if (x % 2).zero?

            0
          }
        },
        2 => {
          items: [66],
          inspections: 0,
          worry_op: ->(x) { x + 5 },
          test_op: lambda { |x|
            return 7 if (x % 5).zero?

            5
          }
        },
        3 => {
          items: [51, 89, 90],
          inspections: 0,
          worry_op: ->(x) { x * 19 },
          test_op: lambda { |x|
            return 6 if (x % 7).zero?

            4
          }
        },
        4 => {
          items: [75, 94, 66, 90, 77, 82, 61],
          inspections: 0,
          worry_op: ->(x) { x + 1 },
          test_op: lambda { |x|
            return 6 if (x % 17).zero?

            1
          }
        },
        5 => {
          items: [53, 76, 59, 92, 95],
          inspections: 0,
          worry_op: ->(x) { x + 2 },
          test_op: lambda { |x|
            return 4 if (x % 19).zero?

            3
          }
        },
        6 => {
          items: [81, 61, 75, 89, 70, 92],
          inspections: 0,
          worry_op: ->(x) { x * x },
          test_op: lambda { |x|
            return 0 if (x % 3).zero?

            1
          }
        },
        7 => {
          items: [81, 86, 62, 87],
          inspections: 0,
          worry_op: ->(x) { x + 8 },
          test_op: lambda { |x|
            return 3 if (x % 13).zero?

            5
          }
        }
      }

      monkeys =
        if input_type == 'sample'
          sample
        else
          input
        end

      (1..20).each do |_|
        monkeys.each do |_, monkey|
          until monkey[:items].empty?
            monkey[:inspections] += 1
            item = monkey[:items].pop
            item = monkey[:worry_op].call(item) / 3
            monkey_idx = monkey[:test_op].call(item)
            monkeys[monkey_idx][:items] << item
          end
        end
      end

      puts monkeys.values.map { |x| x[:inspections] }.sort.reverse[0, 2].inject(:*)
    end
  end
end
