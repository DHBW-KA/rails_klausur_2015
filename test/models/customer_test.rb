require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'has correct associations' do
    assert_equal :belongs_to, Customer.reflect_on_association(:bill_address).macro
    assert_equal :belongs_to, Customer.reflect_on_association(:ship_address).macro
  end
end
