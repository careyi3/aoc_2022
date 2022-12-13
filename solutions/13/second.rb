# frozen_string_literal: true

module Day13
  module Part2
    def self.run(path, _)
      packets = [[[2]], [[6]]]
      FileReader.for_each_line(path) do |line|
        packets << JSON.parse(line) unless line == ''
      end

      packets =
        packets.sort do |left, right|
          res = left_vs_right(left, right)
          if res.nil?
            0
          elsif res
            -1
          else
            1
          end
        end

      divider_idxs = []
      packets.each_with_index do |val, idx|
        divider_idxs << (idx + 1) if [[[2]], [[6]]].include?(val)
      end
      puts divider_idxs.inject(:*)
    end

    def self.left_vs_right(left, right)
      max_idx = [left.size, right.size].max
      (0..max_idx - 1).each do |idx|
        left_val = left[idx]
        right_val = right[idx]

        return true if left_val.nil? && !right_val.nil?
        return false if right_val.nil? && !left_val.nil?

        if left_val.is_a?(Integer) && right_val.is_a?(Integer)
          return true if left_val < right_val
          return false if left_val > right_val
        end

        res = left_vs_right([left_val], right_val) if left_val.is_a?(Integer) && right_val.is_a?(Array)
        res = left_vs_right(left_val, [right_val]) if left_val.is_a?(Array) && right_val.is_a?(Integer)
        res = left_vs_right(left_val, right_val) if left_val.is_a?(Array) && right_val.is_a?(Array)
        return res unless res.nil?
      end
      nil
    end
  end
end
