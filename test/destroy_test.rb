require 'test_helper'

class DestroyTest < ActiveSupport::TestCase
  test "foreign key constraint converted to validation error" do
    @parent = parents(:prolific)
    assert_no_difference('Parent.count') do
      @parent.destroy
    end
    assert_not_empty @parent.errors[:base]
    assert_match(/Cannot delete record because dependent .* exist/,
                 @parent.errors.first.message)
  end

  test "destroyed without foreign key constraint" do
    @parent = parents(:unfruitful)
    assert_difference('Parent.count', -1) do
      @parent.destroy
    end
    assert_empty @parent.errors[:base]
  end
end
