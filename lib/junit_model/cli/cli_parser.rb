require 'optparse'

module JunitModel
  module CLI
    # The options to be used throughout the CLI Module
    class Options
      attr_accessor :files, :output_path
      def initialize
        self.files = []
        self.output_path = './merged_tests.xml'
      end
    end

    # Parse CLI::Options from ARGV
    class Parser
      def self.parse(argv)
        options = Options.new
        opt_parser = OptionParser.new do |opts|
          opts.banner = 'Usage: example.rb [options]'

          opts.on('-o', '--output OUTPUT', String, 'Output') do |n|
            options.output_path = n
          end

          opts.on('-h', '--help', 'Prints this help') do
            puts opts
            exit
          end
        end

        opt_parser.order(argv) do |file|
          options.files << file unless file.nil?
        end

        opt_parser.parse(argv)
        options
      end
    end
  end
end
