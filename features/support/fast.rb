module Fast
  def write_file(path, content)
    file_system.write(path, content)
  end

  def run_refactoring(name, *args)
    Raffle::CLI.new(file_system).run(name, *args)
  end

  def assert_file_content(path, content)
    file_system.read(path).should == content
  end

  def file_system
    @file_system ||= StubbedFileSystem.new
  end

  class StubbedFileSystem
    def write(path, content)
      files[path] = content
    end

    def read(path)
      files.fetch(path)
    end

    private

    def files
      @files ||= {}
    end
  end
end

World(Fast)
