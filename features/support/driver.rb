module Raffle
  module Testing
    module FastDriver
      def write_file(path, content)
        file_system.write(path, content)
      end

      def run_refactoring(name, *args)
        @last_result = Raffle::CLI.new(file_system).run(name, *args)
      end

      def last_output
        @last_result.resulting_code
      end

      def last_exit_status
        @last_result.exit_status
      end

      def assert_file_content(path, content)
        file_system.read(path).should == content
      end

      private

      def file_system
        @file_system ||= StubbedFileSystem.new
      end

      class StubbedFileSystem
        def write(path, content)
          files[path] = content
        end

        def read(path)
          files[path] || raise("File not found: #{path}")
        end

        private

        def files
          @files ||= {}
        end
      end
    end

    require 'aruba/api'
    module EndToEndDriver
      include Aruba::Api

      def run_refactoring(name, *args)
        run("raffle #{name} #{args.join(' ')}")
      end

      alias :assert_file_content :check_exact_file_content
    end
  end
end

if ENV['SLOW']
  ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
  World(Raffle::Testing::EndToEndDriver)
else
  World(Raffle::Testing::FastDriver)
end
