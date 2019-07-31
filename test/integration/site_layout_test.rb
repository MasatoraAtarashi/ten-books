require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do
    get root_path
    assert_template 'top/index'
    assert_select "a[href=?]", signup_path, count: 2
  end
end
