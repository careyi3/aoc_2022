# frozen_string_literal: true

module Day21
  module Part2
    def self.run(path, input_type)
      nums = {}
      FileReader.for_each_line(path) do |line|
        key, val = line.split(': ')
        next if key == 'humn'

        nums[key] = val unless val.to_i.zero?
      end
      op_swap = {
        '+' => '-',
        '-' => '+',
        '*' => '/',
        '/' => '*'
      }
      monkeys = {}
      FileReader.for_each_line(path) do |line|
        a, val = line.split(': ')
        next if a == 'humn'

        if val.to_i.zero?
          b, op, c = val.split

          if a == 'root'
            if input_type == 'sample'
              monkeys['pppw'] = -> { 150 }
              monkeys['sjmn'] = -> { 150 }
            else
              monkeys['pnhm'] = -> { 32_853_424_641_061 }
              monkeys['zvcm'] = -> { 32_853_424_641_061 }
            end
            next
          end

          case op
          when '-'
            monkeys[b] = -> {
              puts "monkeys['#{a}'].call #{op_swap[op]} monkeys['#{c}'].call"
              eval("monkeys['#{a}'].call #{op_swap[op]} monkeys['#{c}'].call", binding, __FILE__, __LINE__)
            } if nums[b].nil?

            monkeys[c] = -> {
              puts "monkeys['#{b}'].call #{op} monkeys['#{a}'].call"
              eval("monkeys['#{b}'].call #{op} monkeys['#{a}'].call", binding, __FILE__, __LINE__)
            } if nums[c].nil?
          when '/'
            monkeys[c] = -> {
              puts "monkeys['#{b}'].call #{op} monkeys['#{a}'].call"
              eval("monkeys['#{b}'].call #{op} monkeys['#{a}'].call", binding, __FILE__, __LINE__)
            } if nums[c].nil?

            monkeys[b] = -> {
              puts "monkeys['#{a}'].call #{op_swap[op]} monkeys['#{c}'].call"
              eval("monkeys['#{a}'].call #{op_swap[op]} monkeys['#{c}'].call", binding, __FILE__, __LINE__)
            } if nums[b].nil?
          else
            monkeys[b] = -> {
              puts "monkeys['#{a}'].call #{op_swap[op]} monkeys['#{c}'].call"
              eval("monkeys['#{a}'].call #{op_swap[op]} monkeys['#{c}'].call", binding, __FILE__, __LINE__)
            } if nums[b].nil?

            monkeys[c] = -> {
              puts "monkeys['#{a}'].call #{op_swap[op]} monkeys['#{b}'].call"
              eval("monkeys['#{a}'].call #{op_swap[op]} monkeys['#{b}'].call", binding, __FILE__, __LINE__)
            } if nums[c].nil?
          end
        else
          monkeys[a] = -> { val.to_i }
        end
      end
      puts monkeys['humn'].call
    end
  end
end
