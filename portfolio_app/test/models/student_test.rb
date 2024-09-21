require "test_helper"

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

require "test_helper"

  # test 1
  test "Should rais an error when saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name: "Burger", school_email: "burger12@msudenver.edu", major: "CS", graduation_date: "2025-06-01")
    end
  end

  #test 2
  test "Should rais an error when saving student without last name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "Burger", school_email: "burger12@msudenver.edu", major: "CS", graduation_date: "2025-06-01")
    end
  end

  # test 3
  test "Should rais an error when saving student without a major" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "Ham", last_name: "Burger", school_email: "major@msudenver.edu", graduation_date: "2025-06-01")
    end
  end

  # test 4
  test "Should rais an error when saving student without a graduation date" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "Ham", last_name: "Burger", school_email: "gradDate@msudenver.edu", major: "CS")
    end
  end

  # test 5
  # uses an email that is already part of a fixture
  test "Should rais an error when saving student with an inuse email" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "Ham", last_name: "Burger", school_email: "bhill@msudenver.edu", major: "CS", graduation_date: "2025-06-01")
    end
  end

  # test 6
  test "Should save a valid student" do
    student = Student.new(first_name: "Hame", last_name: "Burger", school_email: "hburger@university.edu", major: "Mathematics", graduation_date: "2025-06-01")
    assert student.save
  end

  # test 7
  test "Should raise an error when the email format is invalid" do
    invalid_email_student = Student.new(first_name: "Ham", last_name: "Burger", school_email: "email", major: "CS", graduation_date: "2025-06-01")
    assert_not invalid_email_student.save
    assert invalid_email_student.errors[:school_email].any?
  end

  # test 8
  test "Should delete a student record" do
    student = Student.create!(first_name: "Ham", last_name: "Burger", school_email: "hburger@university.edu", major: "CS", graduation_date: "2025-06-01")
    assert_difference('Student.count', -1) do
      student.destroy
    end
  end
end
