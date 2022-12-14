# frozen_string_literal: true

module Day5
  module Part2
    def self.run(path, input_source)
      sample = {
        1 => %w[Z N],
        2 => %w[M C D],
        3 => %w[P]
      }

      input = {
        1 => %w[F H B V R Q D P],
        2 => %w[L D Z Q W V],
        3 => %w[H L Z Q G R P C],
        4 => %w[R D H F J V B],
        5 => %w[Z W L C],
        6 => %w[J R P N T G V M],
        7 => %w[J R L V M B S],
        8 => %w[D P J],
        9 => %w[V W N C D]
      }

      state =
        if input_source == 'input'
          input
        else
          sample
        end

      FileReader.for_each_line(path) do |line|
        command = line.split
        crates = []
        command[1].to_i.times do
          crate = state[command[3].to_i].pop
          crates.unshift(crate)
        end
        state[command[5].to_i] += crates
      end
      puts state.values.map(&:last).join
    end
  end
end
