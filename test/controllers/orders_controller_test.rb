require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  # Hinweis: fields_for
  test "should get new" do
    get :new
    assert_response :success
    assert_instance_of Customer, assigns(:order).customer
    assert_instance_of Address, assigns(:order).customer.ship_address
    assert_instance_of Address, assigns(:order).customer.bill_address
    assert_select 'form.ui.form' do

      assert_select '.two.fields .field input#order_customer_attributes_first_name[placeholder="First Name"]'
      assert_select '.two.fields .field input#order_customer_attributes_last_name[placeholder="Last Name"]'
      assert_select '.field input#order_customer_attributes_email[placeholder="Email"]'

      assert_select '.field input#order_customer_attributes_ship_address_attributes_street[placeholder="Street"]'
      assert_select '.fields .six.wide.field input#order_customer_attributes_ship_address_attributes_zip_code[placeholder="Zip Code"]'
      assert_select '.fields .ten.wide.field input#order_customer_attributes_ship_address_attributes_city[placeholder="City"]'

      assert_select '.field input#order_customer_attributes_bill_address_attributes_street[placeholder="Street"]'
      assert_select '.fields .six.wide.field input#order_customer_attributes_bill_address_attributes_zip_code[placeholder="Zip Code"]'
      assert_select '.fields .ten.wide.field input#order_customer_attributes_bill_address_attributes_city[placeholder="City"]'

      assert_select 'input.ui.green.button'
    end
  end

  # Hinweis: accepts_nested_attributes_for
  test 'the strong parameter methods' do
    assert_equal [:id, :street, :zip_code, :city], @controller.method(:address_params).call
    assert_equal [:first_name, :last_name, :email,
                  ship_address_attributes: @controller.method(:address_params).call,
                  bill_address_attributes: @controller.method(:address_params).call],
                 @controller.method(:customer_params).call
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: {customer_attributes: {
                      first_name: customers(:one).first_name,
                      last_name: customers(:one).last_name,
                      email: customers(:one).email,
                      ship_address_attributes: {
                          street: addresses(:one).street,
                          zip_code: addresses(:one).zip_code,
                          city: addresses(:one).city
                      },
                      bill_address_attributes: {
                          street: addresses(:one).street,
                          zip_code: addresses(:one).zip_code,
                          city: addresses(:one).city
                      }
                  }}
      assert_equal Hash.new, assigns(:order).errors.messages
    end
    assert_equal [], session[:cart_product_ids]

    assert_redirected_to order_path(assigns(:order))
  end

  # Hinweis: accepts_nested_attributes_for
  test "dont create invalid order" do
    post :create, order: {customer_attributes: {
                    first_name: customers(:one).first_name,
                    last_name: customers(:one).first_name}}
    assert_equal({'customer.email'.to_sym => ["can't be blank"]}, assigns(:order).errors.messages)
    assert_response :success
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    first_name = SecureRandom.hex(23)
    patch :update, id: @order, order: {customer_attributes: {
                     first_name: first_name,
                     last_name: 'LAST',
                     email: 'MAIL'
                 }}
    assert_equal Hash.new, assigns(:order).errors.messages
    assert_redirected_to order_path(assigns(:order))
    assert_equal first_name, assigns(:order).customer.first_name
    assert_equal 'LAST', assigns(:order).customer.last_name
    assert_equal 'MAIL', assigns(:order).customer.email
  end

  # Hinweis: accepts_nested_attributes_for
  test "should not update order with invalid values" do
    patch :update, id: @order, order: {customer_attributes: {
                     email: 'MAIL'
                 }}
    assert_equal({'customer.first_name'.to_sym => ["can't be blank"],
                  'customer.last_name'.to_sym => ["can't be blank"]}, assigns(:order).errors.messages)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
