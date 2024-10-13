class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @students = Student.all # Default to all students
  
    # Check if "Show All" button was clicked
    if params[:show_all].present?
      # If "Show All" was clicked, simply fetch all students
      @students = Student.all
    elsif params[:major].present? || params[:date_comparison].present? && params[:graduation_date].present?
      # Filter based on search criteria
      if params[:major].present?
        @students = @students.where(major: params[:major])
      end
  
      if params[:graduation_date].present?
        # Convert graduation_date to Date object
        graduation_date = Date.parse(params[:graduation_date]) rescue nil
  
        # Check date comparison
        if params[:date_comparison] == 'before' && graduation_date
          @students = @students.where("graduation_date < ?", graduation_date)
        elsif params[:date_comparison] == 'after' && graduation_date
          @students = @students.where("graduation_date > ?", graduation_date)
        end
      end
    end
  end


  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :school_email, :major, :minor, :graduation_date, :avatar)
    end
end

