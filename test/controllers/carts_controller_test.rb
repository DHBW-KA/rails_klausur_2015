require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, cart: { customer_id: @cart.customer_id }
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "can't create cart without customer" do
    post :create, cart: { customer_id: nil}
    assert_response :success
    assert_select "#error_explanation > h2", "1 error prohibited this cart from being saved:"
    assert_select "li", "Customer can't be blank"
  end

  test "should show cart" do
    get :show, id: @cart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart
    assert_response :success
  end

  test "should update cart" do
    patch :update, id: @cart, cart: { customer_id: @cart.customer_id }
    assert_redirected_to cart_path(assigns(:cart))
  end

  test "can't update cart without customer" do
    patch :update, id: @cart, cart: { customer_id: nil}
    assert_response :success
    assert_select "#error_explanation > h2", "1 error prohibited this cart from being saved:"
    assert_select "li", "Customer can't be blank"
  end

  test "should destroy cart" do
    assert_difference('Cart.count', -1) do
      delete :destroy, id: @cart
    end

    assert_redirected_to carts_path
  end
end
