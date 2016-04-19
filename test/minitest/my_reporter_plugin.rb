module Minitest
  module MyRubyMineReporterExt
    def report # :nodoc:
      super
      failed = failures + errors + skips
      c = respond_to?(:count) ? count : test_count
      $test_result = (c-failed) / c.to_f
    end
  end

  class MyReporter < Minitest::StatisticsReporter
    include MyRubyMineReporterExt
  end
  class MyRubyMineReporter
    prepend MyRubyMineReporterExt
  end

  def self.plugin_my_reporter_init opts
    self.reporter << MiniTest::MyReporter.new
  end
end