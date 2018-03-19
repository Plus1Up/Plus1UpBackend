require 'test_helper'

class CoachTest < ActiveSupport::TestCase


  def setup
    @coach = Coach.create(mail_address: "test@test.com", name: "John", last_name: "Smith", password: "jKslM")
  end

  test "should not save coach without all values" do
    coach = Coach.new
    assert_not coach.save
  end

  test "should save coach" do
    assert @coach.save
  end

  test "mail address should be unique" do
    coach_duplicate = @coach.dup

    assert_raises(ActiveRecord::RecordNotUnique) do
      # Force object to be saved to database
      coach_duplicate.save(validate: false)
    end
  end

end
