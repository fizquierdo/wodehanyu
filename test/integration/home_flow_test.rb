require 'test_helper'

class HomeFlowTest < ActionDispatch::IntegrationTest
   test "Go to the home page and find a wellcome msg" do
		 get '/'
		 assert_response :success
		 assert_select 'title', 'Wodehanyu'
		 assert_select 'div#main-container', "Let's learn Mandarin 加油!"
		 assert_select 'footer', {count: 1}
		 assert_select 'header', {count: 1}
   end
end
