module Raffle
  class FileSystem
    def read(path)
      File.read(path)
    end

    def write(path, content)
      File.open(path, 'w') do |file|
        file.puts content
      end
    end
  end
end
