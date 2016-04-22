require 'builder'

module JunitModel
  # Convert Junit::TestGroup to XML
  class XMLBuilder
    def self.xml_for_result(result)
      builder = Builder::XmlMarkup.new indent: 2
      builder.instruct! :xml, version: '1.0', encoding: 'UTF-8'
      builder.testsuites(tests: result.test_count, failures: result.failures_count) do |suite_builder|
        result.test_suites.each do |suite|
          suite_builder.testsuite(suite_hash(suite)) do |test_builder|
            suite.test_cases.each do |test_case|
              test_builder.testcase(test_case.to_h)
            end
          end
        end
      end
    end

    def self.suite_hash(suite)
      suite_hash = suite.to_h
      suite_hash.delete(:testcase)
      suite_hash
    end
  end
end
