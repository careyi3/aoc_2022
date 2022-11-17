# frozen_string_literal: true

require('benchmark')

module Instrument
  def self.time
    time =
      Benchmark.measure do # rubocop:disable Style/ExplicitBlockArgument
        yield
      end
    puts "Runtime: #{time.real}"
  end
end
