require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(username: "Dylan", email: "dylan@example.com")
    @recipe = @chef.recipes.build(name: "Chicken Parmagiana", summary: "This is a pretty great and simple recipe",
              description: "Heat oil, Add Onions, Add Tomato Sauce, Add Chicken, Cook for 35 minutes")
  end
  
  test "recipe is valid" do
    assert @recipe.valid?
  end
  
  test "chef_id is present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "name is present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "name is not too long" do
    @recipe.name = "a"*101
    assert_not @recipe.valid?
  end
  
  test "name is not too short" do
    @recipe.name = "aaaa"
    assert_not @recipe.valid?
  end
  
  test "summary is present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end
  
  test "summary is not too long" do
    @recipe.summary = "a"*200
    assert_not @recipe.valid?
  end
  
  test "summary is not too short" do
    @recipe.summary = "aaaa"
    assert_not @recipe.valid?
  end
  
  test "description is present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description is not too long" do
    @recipe.description = "a"*550
    assert_not @recipe.valid?
  end
  
  test "description is not too short" do
    @recipe.description = "aaa"
    assert_not @recipe.valid?
  end
end
