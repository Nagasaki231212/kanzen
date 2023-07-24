require "test_helper"

def setup 
  @user = users(:paco)
end 

class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should login an user by email" do
    post sessions_url, params: { login: @user.email, password: 'testme'}

    assert_redirected_to products_url
    end

  test "should login an user by username" do
    post sessions_url, params: { login: @user.username, password: 'testme'}
  
    assert_redirected_to products_url
    end

    test "should logout" do 
      login  

      delete session_url(@user.id)

      assert_redirected_to products_url 
      assert_equal flash[:notice], 'Tu sesion ha terminado! Hasta la proxima'
    end 
end