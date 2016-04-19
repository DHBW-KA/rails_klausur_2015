require 'test_helper'

class IntegrationTest < ActionDispatch::IntegrationTest

  test "root renders products#index" do
    get root_path
    assert_response :ok
    assert_instance_of ProductsController, @controller
    assert_equal 'index', @controller.action_name
  end

  test 'links in navigation bar' do
    get root_path
    assert_select 'a.item[href="/"]', 'Home'
  end

  test 'can add some products to the cart' do
    put add_to_cart_product_path(products(:one)), format: :js
    put add_to_cart_product_path(products(:two)), format: :js
    get root_path
    assert_select 'ul#cart' do
      [products(:one), products(:two)].each do |product|
        assert_select "li[data-id=\"#{product.id}\"]" do
          assert_select 'b', product.name
          assert_select "a.ui.red.button" do |link|
            assert_equal "/products/#{product.id}/remove_from_cart.js", link.attr('href').value
            assert_equal 'true', link.attr('data-remote').value
            assert_equal 'delete', link.attr('data-method').value
          end
        end
      end
    end
  end

  test 'can remove products from cart' do
    put add_to_cart_product_path(products(:one)), format: :js
    put add_to_cart_product_path(products(:two)), format: :js
    get root_path
    delete remove_from_cart_product_path(products(:two)), format: :js
    assert_equal [products(:one).id], session[:cart_product_ids]
  end
end