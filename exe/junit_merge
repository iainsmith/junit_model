#!/usr/bin/env ruby

require 'junit_model'

options = JunitModel::CLI::Parser.parse(ARGV)

if options.files.count != 2
  puts 'Failed: You must pass exactly 2 files to be merged'
  exit
end

JunitModel::CLI::Merger.merge(options)
