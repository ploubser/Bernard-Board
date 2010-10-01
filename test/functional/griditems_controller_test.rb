require 'test_helper'

class GriditemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:griditems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create griditems" do
    assert_difference('Griditems.count') do
      post :create, :griditems => { }
    end

    assert_redirected_to griditems_path(assigns(:griditems))
  end

  test "should show griditems" do
    get :show, :id => griditems(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => griditems(:one).to_param
    assert_response :success
  end

  test "should update griditems" do
    put :update, :id => griditems(:one).to_param, :griditems => { }
    assert_redirected_to griditems_path(assigns(:griditems))
  end

  test "should destroy griditems" do
    assert_difference('Griditems.count', -1) do
      delete :destroy, :id => griditems(:one).to_param
    end

    assert_redirected_to griditems_path
  end
end
