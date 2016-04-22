require 'spec_helper'

describe JunitModel::XMLBuilder do
  it 'converts a passing Junit::TestGroup to XML' do
    path = "#{File.dirname(__FILE__)}/fixtures/output_a.xml"
    file = File.read path
    result = JunitModel::Parser.read_path(path)
    xml = JunitModel::XMLBuilder.xml_for_result(result)
    expect(xml).to eql file
    expect(xml).to eql result.to_xml
  end

  it 'converts a failing Junit::TestGroup to XML' do
    path = "#{File.dirname(__FILE__)}/fixtures/output_b.xml"
    file = File.read path
    result = JunitModel::Parser.read_path(path)
    xml = JunitModel::XMLBuilder.xml_for_result(result)
    expect(xml).to eql file
    expect(xml).to eql result.to_xml
  end
end
