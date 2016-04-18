require 'ostruct'
require 'junit_model/models'
require 'xmlsimple'

module JunitModel
  # Parse a file path into a Junit::TestGroup
  class Parser
    def self.read_path(path)
      Parser.new.read_path(path)
    end

    def self.read_string(string)
      Parser.new.read_string(string)
    end

    def read_path(path)
      test_file = File.read(path)
      read_string(test_file)
    end

    def read_string(string)
      test_output_hash = XmlSimple.xml_in string
      test_group = build_test_group(test_output_hash)
      test_group
    end

    private

    def build_test_group(test_output_hash)
      test_output_hash['test_suites'] = test_output_hash['testsuite']
      test_output_hash.delete('testsuite')
      group = JunitModel::TestGroup.new(test_output_hash)
      group.test_suites = build_test_suites(group.test_suites)
      group
    end

    def build_test_suites(test_suties_array)
      test_suties_array.map do |suite_hash|
        suite = JunitModel::TestSuite.new(suite_hash)
        suite.testcase = build_test_cases(suite.testcase)
        suite
      end
    end

    def build_test_cases(test_cases_array)
      test_cases_array.map { |test_hash| JunitModel::TestCase.new(test_hash) }
    end
  end
end
