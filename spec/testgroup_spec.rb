require 'spec_helper'

describe JunitModel::TestGroup do
  let(:subject) do
    JunitModel::TestGroup.new(hey: 'there', tests: '1', failures: '2')
  end

  it '#initialize' do
    expect(subject).to_not be_nil
  end

  it '#test_count' do
    expect(subject.test_count).to eq 1
  end

  it '#failure_count' do
    expect(subject.failures_count).to eq 2
  end

  it '#passed' do
    expect(subject.passed).to be false
  end

  it '#to_h' do
    expect(subject.to_h).to eq(hey: 'there', tests: '1', failures: '2')
  end
end
