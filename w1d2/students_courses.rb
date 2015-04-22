class Student
  attr_reader :first_name, :last_name
  attr_accessor :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{first_name} #{last_name}"
  end

  def enroll(course)
    courses << course
    course.students << self
  end

  def course_load
    dept_credits = Hash.new { |h, k| h[k] = 0 }
    courses.each do |course|
      dept_credits[course.department] += course.credits
    end

    dept_credits
  end
end

class Course

  attr_reader :name, :department, :credits
  attr_accessor :students

  def initialize(name, department, credits)
    @name = name
    @department = department
    @credits = credits
    @students = []
  end

  def add_student(student)
    students << student
    student.courses << self
  end
end


student = Student.new("john", "smith")
student1 = Student.new("jane", "doe")
course1 = Course.new("1", "A", 4)
course2 = Course.new("2", "A", 3)

student.enroll(course1)
student.enroll(course2)
student1.enroll(course1)
course1.add_student(student1)
p course1.students
