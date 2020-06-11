require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup()
    @category = Category.new(name: "Sport")
  end

  test "Category should be valid" do
    assert @category.valid?
  end

  test "Name should be present" do
    @category.name = ""
    assert_not @category.valid?
  end

  test "Name should be unique" do
    @category.save
    @category2 = Category.new(name: "Sport")
    assert_not @category2.valid?
  end

  test "Name shouldnt be to long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "Name shouldnt be to short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end
