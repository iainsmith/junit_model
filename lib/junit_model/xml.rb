require 'builder'

module JunitModel
  # Convert Junit::TestGroup to XML
  class XMLBuilder
    def self.xml_for_result(result)
      builder = Builder::XmlMarkup.new indent: 2
      builder.instruct! :xml, version: '1.0', encoding: 'UTF-8'
      builder.testsuites(tests: result.test_count, failures: result.failures_count) do |suite_builder|
        result.test_suites.each do |suite|
          suite_builder.testsuite(name: suite.name, tests: suite.tests, failures: suite.failures) do |test_builder|
            suite.test_cases.each do |test_case|
              test_builder.testcase(classname: test_case.classname, name: test_case.name, time: test_case.time)
            end
          end
        end
      end
    end
  end
end
