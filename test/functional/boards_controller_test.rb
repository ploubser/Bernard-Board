require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boards" do
    assert_difference('Boards.count') do
      post :create, :boards => { }
    end

    assert_redirected_to boards_path(assigns(:boards))
  end

  test "should show boards" do
    get :show, :id => boards(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => boards(:one).to_param
    assert_response :success
  end

  test "should update boards" do
    put :update, :id => boards(:one).to_param, :boards => { }
    assert_redirected_to boards_path(assigns(:boards))
  end

  test "should destroy boards" do
    assert_difference('Boards.count', -1) do
      delete :destroy, :id => boards(:one).to_param
    end

    assert_redirected_to boards_path
  end
end
