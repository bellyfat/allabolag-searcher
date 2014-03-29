require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  fixtures :results

  test "should find search" do
    result = Result.search("apoex")
    assert_equal true, result.first.found
    assert_equal '556633-4149', result.first.reg_number 
  end

  test "should not find search" do
    result = Result.search("other")
    assert result.empty?
  end
end
