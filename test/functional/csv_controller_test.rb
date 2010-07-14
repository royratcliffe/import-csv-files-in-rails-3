require 'test_helper'

class CsvControllerTest < ActionController::TestCase
  test "should get import" do
    get :import
    assert_response :success
  end

end
