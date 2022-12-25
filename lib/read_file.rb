# frozen_string_literal: true

class FileReader
  class << self
    def read_file(path)
      File.read(path.strip)
    end

    def for_each_line(path, no_strip: false)
      File.readlines(path).each do |line|
        line = line.strip unless no_strip
        yield(line)
      end
    end
  end
end
