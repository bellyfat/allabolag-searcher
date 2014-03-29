require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  test "should save the result" do
    ResultsController.create("midasplayer", true, '556653-2064')
    result = Result.search("midasplayer")
    assert_equal true, result.first.found
    assert_equal '556653-2064', result.first.reg_number
  end
end
