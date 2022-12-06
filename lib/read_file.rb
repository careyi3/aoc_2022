# frozen_string_literal: true

class FileReader
  class << self
    def read_file(path)
      File.read(path.strip)
    end

    def for_each_line(path)
      File.readlines(path).each do |line|
        yield(line.strip)
      end
    end
  end
end
