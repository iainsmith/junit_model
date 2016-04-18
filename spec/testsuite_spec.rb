require 'spec_helper'

describe JunitModel::TestSuite do
  before do
    @passed_test_case = JunitModel::TestCase.new(name: 'test')
    @failed_test_case = JunitModel::TestCase.new(name: 'test',
                                                 failure: 'some reason')
    @suite = JunitModel::TestSuite.new(
      name: 'hey',
      testcase: [@passed_test_case, @failed_test_case]
    )
  end

  it '#passed_test_cases' do
    passed = @suite.passed_test_cases
    expect(passed.first).to equal @passed_test_case
  end

  it '#failed_test_cases' do
    failed = @suite.failed_test_cases
    expect(failed.first).to equal @failed_test_case
  end
end
