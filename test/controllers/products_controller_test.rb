require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    assert_select 'table.ui.table'
  end

  test 'shows the "add to cart" link' do
    get :index
    assert Product.count > 0
    Product.all.each do |product|
      assert_select "tr[data-id=\"#{product.id}\"]" do
        assert_select "a" do |link|
          assert_equal "#{add_to_cart_product_path(product)}", link.attr('href').value
          assert_equal "true", link.attr('data-remote').value
          assert_equal "put", link.attr('data-method').value
        end
      end
    end
  end

  test 'shows the cart' do
    get :index
    assert_select 'main.ui.page.grid > .row > .column > .ui.right.attached.rail > .ui.blue.segment' do
      assert_select 'h2', 'Cart'
      assert_select '#cart'
      assert_select 'a.ui.green.button[href="/orders/new"]', text: 'Checkout'
    end
  end

  test 'can add a product to the cart' do
    put :add_to_cart, id: @product, format: :js
    assert_response :ok
    assert_equal [@product.id], session[:cart_product_ids]
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'form.ui.form'
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { name: @product.name, price: @product.price, weight: @product.weight }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should't create an invalid product" do
    post :create, product: { name: @product.name, price: -@product.price, weight: -@product.weight }
    assert_equal({price: ['must be greater than 0'], weight: ['must be greater than 0'], name: []}, assigns(:product).errors.messages)
end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { name: @product.name, price: @product.price, weight: @product.weight }
    assert_redirected_to product_path(assigns(:product))
  end

  test 'should not update product with invalid values' do
    patch :update, id: @product, product: { name: @product.name, price: -@product.price, weight: -@product.weight }
    assert_equal({price: ['must be greater than 0'], weight: ['must be greater than 0'], name: []}, assigns(:product).errors.messages)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
