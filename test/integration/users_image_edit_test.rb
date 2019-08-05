require 'test_helper'

class UsersImageEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  # 成功
  test "edit image" do
    log_in_as(@user)
    get "/users/#{@user.id}/image"
    assert_template 'users/edit_image'
    assert_select 'img.avatar'
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    patch "/users/#{@user.id}/image", params: { user: { picture: picture } }
    assert_not flash.empty?
    user = assigns(:user)
    assert user.picture?
    follow_redirect!
    assert_template 'users/edit_image'
    assert_select 'img[src=?]', user.picture.url
    # 削除
    patch "/users/#{@user.id}/image", params: { user: { picture: picture,
                                                        remove_picture: 'on' } }
    assert_not flash.empty?
    user = assigns(:user)
    assert_not user.picture?
    follow_redirect!
    assert_template 'users/edit_image'
    assert_select 'img[src=?]', '/assets/default.png'
  end

end
