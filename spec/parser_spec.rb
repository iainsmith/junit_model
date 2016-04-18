require 'spec_helper'

describe JunitModel::Parser do
  describe '#read' do
    subject do
      path = "#{File.dirname(__FILE__)}/fixtures/output_a.xml"
      JunitModel::Parser.new.read_path(path)
    end

    it 'produces a Junit::TestGroup' do
      expect(subject.class).to eql JunitModel::TestGroup
    end

    context 'Resulting Junit::TestGroup reflects xml' do
      it '#tests' do
        expect(subject.tests).to eq '5'
      end

      it '#test_count' do
        expect(subject.test_count).to eq 5
      end

      it '#failures' do
        expect(subject.failures).to eq '0'
        expect(subject.failures_count).to eq 0
      end

      it '#passed?' do
        expect(subject.passed?).to be true
      end

      let(:test_suite_a) { subject.test_suites.first }
      let(:first_test_case) { test_suite_a.test_cases.first }
      let(:test_suite_b) { subject.test_suites[1] }

      it '#test_suites' do
        expect(test_suite_a.passed?).to be true
        expect(test_suite_a.test_count).to eq 2

        expect(test_suite_b.passed?).to be true
        expect(test_suite_b.test_count).to eq 3
      end

      it '#test_cases' do
        expect(first_test_case.passed?).to be true
        expect(first_test_case.name).to eq 'a_1'
        expect(first_test_case.classname).to eq 'SuiteA'
      end
    end
  end
end
