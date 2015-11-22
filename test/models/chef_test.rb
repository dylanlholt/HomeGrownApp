require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(username: "Dylan", email: "dylan@example.com")
  end

  test "chef is valid" do
  	assert @chef.valid?
  end
  
  test "username is not too short" do
  	@chef.username = "aa"
  	assert_not @chef.valid?
  end

	test "username is not too long" do
		@chef.username = "a"*50
		assert_not @chef.valid?
	end
	
	test "email is present" do
		@chef.email = " "
		assert_not @chef.valid?
	end
	
	test "email is within bounds" do
		@chef.email = "a"*100+"@example.com"
		assert_not @chef.valid?
	end
	
	test "email is unique" do
		dup_chef = @chef.dup
		dup_chef.email = @chef.email.upcase
		@chef.save
		assert_not dup_chef.valid?
	end
	
	test "email accepts valid addresses" do
		valid_addresses = %w[ggg@eee.com dylan.lee@hello.apple.com new+old@eee.com rock_star@example.com]
		valid_addresses.each do |va|
			@chef.email = va
			assert @chef.valid?, "#{va.inspect} should be valid"
		end
	end
	
	test "email rejects invalid addresses" do
		invalid_addresses = %w[gg@example,com ggg@example dylanl_at_example.com things]
		invalid_addresses.each do |ia|
			@chef.email = ia
			assert_not @chef.valid?, "#{ia.inspect} should be invalid"
		end
	end
end	