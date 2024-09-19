require "test_helper"

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

require "test_helper"

  test "Should rais an error when saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name: "Burger", school_email: "burger12@msudenver.edu", major: "CS")
    end
  end

  test "Should rais an error when saving student without last name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "Burger", school_email: "burger12@msudenver.edu", major: "CS")
    end
  end

end
