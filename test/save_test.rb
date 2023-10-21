require 'test_helper'

class SaveTest < ActiveSupport::TestCase
  test "foreign key constraint converted to validation error" do
    @child = children(:one)
    @child.parent_id = ActiveRecord::FixtureSet.identify(:nonexistent)
    @child.save
    assert_not_empty @child.errors[:parent_id]
    assert_match(/is invalid/, @child.errors.first.message)
  end
end
