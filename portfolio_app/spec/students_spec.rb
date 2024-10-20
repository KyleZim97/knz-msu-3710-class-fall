require 'rails_helper'
 
#request specs for the Students resource focusing on HTTP requests
RSpec.describe "Students", type: :request do

  # GET /students (index)
  describe "GET /students" do
    context "when students exist" do
      let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      # Test 1: Returns a successful response and displays the search form
      it "returns a successful response and displays the search form" do
        get students_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Search') # Ensure search form is rendered
      end

      # Test 2: Ensure it does NOT display students without a search
      it "does not display students until a search is performed" do
        get students_path
        expect(response.body).to_not include("Aaron")
      end
    end

    # Test 3: Handle missing records or no search criteria provided
    context "when no students exist or no search is performed" do
      it "displays a message prompting to search" do
        get students_path
        expect(response.body).to include("Please enter search criteria to find students")
      end
    end
  end

  # Search functionality
  describe "GET /students (search functionality)" do
    let!(:student1) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }
    let!(:student2) { Student.create!(first_name: "Jackie", last_name: "Joyner", school_email: "joyner@msudenver.edu", major: "Data Science and Machine Learning Major", graduation_date: "2026-05-15") }

    # Test 4: Search by major
    it "returns students matching the major" do
      get students_path, params: { major: "Computer Science BS" }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

    # Test 5: Search by expected graduation date (before)
    it "returns students graduating before the given date" do
      get students_path, params: { graduation_date: "2026-01-01", date_comparison: "before" }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

    # Test 6: Search by expected graduation date (after)
    it "returns students graduating after the given date" do
      get students_path, params: { graduation_date: "2026-01-01", date_comparison: "after" }
      expect(response.body).to include("Jackie")
      expect(response.body).to_not include("Aaron")
    end
  end

  # POST /students (create)
  describe "POST /students" do
    context "with valid parameters" do
      # Test 7: Create a new student and ensure it redirects
      it "creates a new student and redirects" do
        expect {
          post students_path, params: { student: { 
            first_name: "Aaron", 
            last_name: "Gordon", 
            school_email: "gordon@msudenver.edu", 
            major: "Computer Science BS", 
            graduation_date: "2025-05-15" 
          } }
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:found)  # Expect redirect after creation
        follow_redirect!
        expect(response.body).to include("Aaron")  # Student's details in the response
      end

      # Test 8 (Student will complete this part)
      # Ensure that it returns a 201 status or check for creation success
      it "ensures student creation success" do
        # Perform a POST request to create a student
        post students_path, params: { student: { 
          first_name: "Emily", 
          last_name: "Blunt", 
          school_email: "blunt@msudenver.edu", 
          major: "Data Science BS", 
          graduation_date: "2024-12-20" 
        } }
      
        # Check if the response is 201
        expect(response).to have_http_status(:found)
      
        # Ensure that the student was indeed created
        expect(Student.exists?(school_email: "blunt@msudenver.edu")).to be true
      end      
    end

    context "with invalid parameters" do
      # Test 9 (Student will complete this part)
      # Ensure it does not create a student and returns a 422 status
      it "does not create a new student, an error message is displayed, and returns a 422 status" do
        expect {
          post students_path, params: { student: { 
            first_name: "Aaron", 
            last_name: "Gordon", 
            school_email: "",  # Leaving email blank to trigger validation failure
            major: "Computer Science BS", 
            graduation_date: "2025-05-15" 
          } }
        }.to_not change(Student, :count)  # Expect no change in count

        # Expect an error message to be displayed to the body
        expect(response.body).to include("errors prohibited this student from being saved")
        expect(response).to have_http_status(422)
      end
    end
  end

  # GET /students/:id (show)
  describe "GET /students/:id" do
    context "when the student exists" do
      let!(:student) { Student.create!(
        first_name: "Aaron", 
        last_name: "Gordon", 
        school_email: "gordon@msudenver.edu", 
        major: "Computer Science BS", 
        graduation_date: "2025-05-15") }

      # Test 10 (Student will complete this part)
      # Ensure it returns a successful response (200 OK)
      it "returns a successful response 200 code" do
        get student_path(student)


        # Expect a 200 code
        expect(response).to have_http_status(200)
      end 

      # Test 11 (Student will complete this part)
      # Ensure it includes the student's details in the response body
      it "response includes the student's details" do
        get student_path(student)

        # Expect student details
        expect(response.body).to include("Aaron")
        expect(response.body).to include("Gordon")
        expect(response.body).to include("gordon@msudenver.edu")
        expect(response.body).to include("Computer Science BS")
        expect(response.body).to include("2025-05-15")
      end
    end

    # Test 12: Handle missing records
    context "when the student does not exist" do
      it "returns a unsuccessful response 404 code" do
        get student_path(9999)

        # Expect a 200 code
        expect(response).to have_http_status(404)
      end
    end
  end

  # DELETE /students/:id (destroy)
  describe "DELETE /students/:id" do
    let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

    # Test 13: Deletes the student and redirects
    context "when student exists" do
      it "deletes the student and redirects" do
        expect { delete student_path(student) }.to change(Student, :count).by(-1)
        
        expect(response).to have_http_status(:found)  # Check for a redirect
        follow_redirect!  # Follow the redirect
        expect(response.body).to include("Student was successfully destroyed")
      end
    end

    # Test 14: Returns a 404 when trying to delete a non-existent student
    context "when student does not exist" do
      it "returns a 404 status when trying to delete a non-existent student" do
        delete "/students/9999"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
