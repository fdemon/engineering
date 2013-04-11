require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class SupplierTest < Test::Unit::TestCase
  context "Supplier Model" do
    should 'construct new instance' do
      @supplier = Supplier.new
      assert_not_nil @supplier
    end
  end
end
