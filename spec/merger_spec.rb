require 'spec_helper'

describe JunitModel::Merger do
  describe '#merge' do
    path_b = "#{File.dirname(__FILE__)}/fixtures/output_b.xml"
    path_c = "#{File.dirname(__FILE__)}/fixtures/output_c.xml"
    path_d = "#{File.dirname(__FILE__)}/fixtures/output_d.xml"

    context 'matching xml output' do
      let(:subject) do
        test_group_a = JunitModel::Parser.read_path(path_c)
        test_group_b = JunitModel::Parser.read_path(path_b)

        expect(test_group_a.passed?).to be false
        expect(test_group_b.passed?).to be false

        JunitModel::Merger.merge(test_group_a, test_group_b)
      end

      it 'optimistically merges failing tests to passed tests' do
        expect(subject.class).to be JunitModel::TestGroup
        expect(subject.passed?).to be true
        expect(subject.test_count).to eq 5
        expect(subject.failure_count).to eq 0
        expect(subject.test_suites.count).to eq 2
      end
    end

    describe 'disjoint xml output' do
      let(:subject) do
        result_a = JunitModel::Parser.read_path(path_d)
        result_b = JunitModel::Parser.read_path(path_b)
        JunitModel::Merger.merge(result_b, result_a)
      end

      it 'joins the two test groups' do
        expect(subject.test_count).to eq 31
        expect(subject.failures_count).to eq 4
        expect(subject.passed?).to be false
      end
    end
  end
end
