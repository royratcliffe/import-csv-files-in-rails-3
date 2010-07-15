require 'test_helper'

class ImportTablesControllerTest < ActionController::TestCase
  setup do
    @import_table = import_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:import_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create import_table" do
    assert_difference('ImportTable.count') do
      post :create, :import_table => @import_table.attributes
    end

    assert_redirected_to import_table_path(assigns(:import_table))
  end

  test "should show import_table" do
    get :show, :id => @import_table.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @import_table.to_param
    assert_response :success
  end

  test "should update import_table" do
    put :update, :id => @import_table.to_param, :import_table => @import_table.attributes
    assert_redirected_to import_table_path(assigns(:import_table))
  end

  test "should destroy import_table" do
    assert_difference('ImportTable.count', -1) do
      delete :destroy, :id => @import_table.to_param
    end

    assert_redirected_to import_tables_path
  end
end
