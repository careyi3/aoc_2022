# frozen_string_literal: true

class FileReader
  class << self
    def read_file(path)
      File.read(path)
    end

    def for_each_line(path)
      File.readlines(path).each do |line| # rubocop:disable Style/ExplicitBlockArgument
        yield(line)
      end
    end
  end
end
