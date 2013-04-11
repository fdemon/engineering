require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class WorkerTest < Test::Unit::TestCase
  context "Worker Model" do
    should 'construct new instance' do
      @worker = Worker.new
      assert_not_nil @worker
    end
  end
end
