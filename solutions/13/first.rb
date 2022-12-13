# frozen_string_literal: true

module Day13
  module Part1
    def self.run(path, _)
      pair1 = nil
      pair2 = nil
      pairs = {}
      idx = 1
      FileReader.for_each_line(path) do |line|
        if line == ''
          pairs[idx] = { left: pair1, right: pair2 }
          idx += 1
          pair1 = nil
          pair2 = nil
        elsif pair1.nil?
          pair1 = eval(line)
          pair2 = nil
        else
          pair2 = eval(line)
        end
      end

      sum = 0
      pairs.each do |key, val|
        pairs[key][:order] = left_vs_right(val[:left], val[:right])
        sum += key if pairs[key][:order]
      end
      puts sum
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
