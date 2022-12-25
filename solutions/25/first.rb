# frozen_string_literal: true

module Day25
  module Part1
    NUMERALS = {
      '2' => 2,
      '1' => 1,
      '0' => 0,
      '-' => -1,
      '=' => -2
    }.freeze

    def self.run(path, _)
      nums = []
      FileReader.for_each_line(path) do |line|
        digits = line.chars.map { |x| NUMERALS[x] }
        sum = 0
        digits.reverse.each_with_index do |digit, power|
          sum += digit * (5**power)
        end
        nums << sum
      end
      snafu = ''
      num = nums.sum
      while num.positive?
        num, rem = num.divmod(5)
        case rem
        when 0, 1, 2
          snafu += rem.to_s
        when 3
          num += 1
          snafu += '='
        when 4
          num += 1
          snafu += '-'
        end
      end
      puts snafu.reverse
    end
  end
end
