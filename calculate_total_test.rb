require 'minitest/autorun'
require 'minitest/colorize'
require './calculate_total'

class CalculateTotalTest < Minitest::Unit::TestCase
  def test_with_empty_order
    assert_equal "$0.00", calculate_total()
  end
  def test_with_one_item
    assert_equal "$4.20", calculate_total({quantity: 2, price: 2.00})
  end
  def test_with_two_items
    assert_equal "$7.00", calculate_total({quantity: 2, price: 2.00}, {quantity: 3, price: 0.89})
  end
end