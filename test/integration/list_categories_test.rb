require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup 
    @cat = Category.create(name: "Sports")
    @cat2 = Category.create(name: "Travel")
  end

  test "should list categories in the index page and each category goes to the show page" do
    get '/categories'
    assert_select 'a[href=?]', category_path(@cat), text: @cat.name
    assert_select 'a[href=?]', category_path(@cat2), text: @cat2.name
  end
end
