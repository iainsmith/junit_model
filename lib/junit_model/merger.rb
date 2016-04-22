require 'junit_model/parser'

module JunitModel
  # Merges two Junit::TestGroup into a single TestGroup
  class Merger
    # Optermistically merge two test_groups into one.
    #
    # @param test_group_a [Junit::TestGroup] a test group to be merged
    # @param test_group_b [Junit::TestGroup] a test group to be merged
    # @return [Junit::TestGroup] the merge test group.
    def self.merge(test_group_a, test_group_b)
      final_suites = merge_suite_a_into_suite_b(test_group_a, test_group_b)
      final_suites += merge_suite_a_into_suite_b(test_group_b, test_group_a)
      result_from_array(final_suites)
    end

    def self.merge_suite_a_into_suite_b(suite_a, result_b)
      merged_suites = []
      suites_grouped_by_name = suites_keyed_by_name(result_b)
      suite_a.test_suites.each do |test_suite_a|
        suite = suites_grouped_by_name[test_suite_a.name]
        if suite.nil?
          merged_suites << test_suite_a
          next
        end

        test_suite_b = suite.first
        merged_suite = merge_suite(test_suite_a, test_suite_b)
        merged_suites << merged_suite unless merged_suite.nil?
        suites_grouped_by_name.delete test_suite_a.name
      end
      result_b.test_suites = suites_grouped_by_name.values.flatten
      merged_suites
    end

    def self.suites_keyed_by_name(suite)
      suite.test_suites.group_by(&:name)
    end

    def self.merge_suite(suite_a, suite_b)
      return suite_a if suite_b.nil?
      return suite_b if suite_a.nil?
      merged_test_cases = merged_test_cases(suite_a, suite_b)
      failed_count = merged_test_cases.reject(&:passed?).count
      JunitModel::TestSuite.new(
        classname: suite_a.name,
        tests: merged_test_cases.count.to_s,
        failures: failed_count.to_s,
        testcase: merged_test_cases
      )
    end

    def self.merged_test_cases(suite_a, suite_b)
      test_cases = []

      suite_b_test_cases = suite_b.test_cases.group_by(&:name)
      suite_a.test_cases.each do |test_case|
        test_case_b = suite_b_test_cases[test_case.name].first
        test_cases << merge_case(test_case, test_case_b)
      end
      test_cases
    end

    def self.merge_case(case_a, case_b)
      return case_a if case_a.passed? || case_b.nil?
      case_b
    end

    def self.result_from_array(merged_suites)
      merged_suites.reject!(&:nil?)
      test_count = merged_suites.inject(0) { |a, e| a + e.test_count }
      failure_count = merged_suites.inject(0) { |a, e| a + e.failures_count }
      JunitModel::TestGroup.new(
        tests: test_count.to_s,
        failures: failure_count.to_s,
        test_suites: merged_suites
      )
    end

    private_class_method :result_from_array, :merge_case, :merge_suite
    private_class_method :merge_suite_a_into_suite_b, :suites_keyed_by_name
    private_class_method :merged_test_cases
  end
end
