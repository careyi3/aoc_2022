# frozen_string_literal: true

module FileReader
  def self.read_file(path)
    File.read(path)
  end

  def self.for_each_in(path)
    File.readlines(path).each do |line| # rubocop:disable Style/ExplicitBlockArgument
      yield(line)
    end
  end
end
