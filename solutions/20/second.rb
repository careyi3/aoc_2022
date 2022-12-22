# frozen_string_literal: true

module Day20
  module Part2
    def self.run(path, _)
      data = []
      idx = 0
      FileReader.for_each_line(path) do |line|
        data << (line.to_i.zero? ? 0 : "#{idx}:#{line.to_i * 811_589_153}")
        idx += 1
      end
      data_size = data.size
      new_data = data.clone
      10.times do
        data.each do |d|
          next if d.is_a?(Integer)

          val = d.split(':')[1].to_i

          ridx = new_data.find_index(d)
          move_to = (ridx + val) % (data_size - 1)
          move_to -= 1 if move_to.zero?
          new_data.delete_at(new_data.find_index(d))
          new_data.insert(move_to, d)
        end
      end
      zero_idx = new_data.find_index(0)
      ans = [
        new_data[(zero_idx + 1000) % data_size].split(':')[1].to_i,
        new_data[(zero_idx + 2000) % data_size].split(':')[1].to_i,
        new_data[(zero_idx + 3000) % data_size].split(':')[1].to_i
      ].sum
      puts ans
    end
  end
end
