require 'ostruct'

module JunitModel
  # A TestGroup is the top level object in a Junit tree.
  class TestGroup < OpenStruct
    def test_count
      tests.to_i
    end

    def failures_count
      failures.to_i
    end

    def passed?
      failures_count == 0
    end

    def to_xml
      XMLBuilder.xml_for_result(self)
    end

    alias failure_count failures_count
    alias passed passed?
  end
end

module JunitModel
  # A TestSuite belongs to a TestGroup and has an array of TestCase
  class TestSuite < OpenStruct
    def test_count
      tests.to_i
    end

    def failures_count
      failures.to_i
    end

    def passed?
      failures == '0'
    end

    def test_cases
      testcase
    end

    def failed_test_cases
      test_cases.reject(&:passed?)
    end

    def passed_test_cases
      test_cases.select(&:passed?)
    end

    alias failure_count failures_count
    alias passed passed?
  end
end

module JunitModel
  # A TestCase is the atomic unit of a Junit file
  class TestCase < OpenStruct
    def passed?
      failure.nil?
    end
  end
end
