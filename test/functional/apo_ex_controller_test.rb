require 'test_helper'

class ApoExControllerTest < ActionController::TestCase
  fixtures :results

  test "should get allabolag" do
    get :allabolag
    assert_response :success
  end

  test "should scrape a result" do
    controller = ApoExController.new
    result = controller.instance_eval{ scrape("allabolag") }
    assert_equal '556730-7367', result.text[/\d{6}\-\d{4}/]
  end

  test "should get json response" do
    params = { :format => 'json' }
    get :allabolag, params

    response = JSON.parse(@response.body)
    assert_equal "012345-6789", response[0]["reg_number"]
  end

  test "should get xml response" do
    params = { :format => 'xml' }
    get :allabolag, params

    response = Nokogiri::XML(@response.body)
    assert_equal "012345-6789", response.at_xpath("/results/result/reg-number").text
  end
end
