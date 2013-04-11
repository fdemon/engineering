require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ProductItemTest < Test::Unit::TestCase
  context "ProductItem Model" do
    should 'construct new instance' do
      @product_item = ProductItem.new
      assert_not_nil @product_item
    end
  end
end
