module JunitModel
  module CLI
    class Merger
      def self.merge(options)
        path_a = options.files[0]
        path_b = options.files[1]
        output_path = options.output_path

        test_a = JunitModel::Parser.read_path(path_a)
        test_b = JunitModel::Parser.read_path(path_b)

        merged_tests = JunitModel::Merger.merge(test_a, test_b)
        puts "Merged #{path_a} and #{path_b} to #{output_path}"
        puts "Tests:#{merged_tests.tests} Failures:#{merged_tests.failure_count} Suites:#{merged_tests.test_suites.count}"
        xml = merged_tests.to_xml
        File.open(output_path, 'w') do |file|
          file.write(xml)
        end
      end
    end
  end
end
