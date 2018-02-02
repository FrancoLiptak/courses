require 'test_helper'

class EvaluationInstanceTest < ActiveSupport::TestCase

  def setup
    @instance = evaluation_instances(:one)
  end

  # --- Test for validations ---

  test "title cant be nil" do 
    @instance.title = nil 
    assert_not @instance.valid?
  end

  test "passing score cant be nil" do 
    @instance.passing_score = nil 
    assert_not @instance.valid?
  end

  test "top score cant be nil" do 
    assert_not @instance.top_score = nil 
  end

  test "passing score cant be bigger than top score" do 
    @instance.passing_score = 5
    @instance.top_score = 1
    assert_not @instance.valid?
  end

  test "this evaluation instance must be created" do 
    assert @instance.valid?
  end 

  test "title must be unique in a course" do 
    another_evaluation = evaluation_instances(:two)
    @instance.title = another_evaluation.title
    @instance.course = another_evaluation.course
    assert_not @instance.valid?
  end 

  # --- Tests for methods --- 

  test "the student must be absent" do 
    student = @instance.course.students.build(course: courses(:one), last_name: "Brost", name: "Pepe", dni: 38659423, student_number: 56564/5, email: "pepo.brost@gmail.com")
    assert_not (@instance.present_student? student)
  end
  
  test "the student must be present" do 
    instance = evaluation_instances(:two)
    student = instance.course.students.build(course: courses(:two), last_name: "Brost", name: "Pepe", dni: 38659423, student_number: 56564/5, email: "pepo.brost@gmail.com")
    instance.scores.build(score: 20, student: student)
    assert (instance.present_student? students(:one))
  end 

  test "must know the number of disapproved students" do
    assert_equal(1, @instance.number_of_disapproved)
  end 

  test "must know the number of approved students" do 
    assert_equal(1, @instance.number_of_approved)
  end 

  test "must know the percentage of approved students" do
    evaluation = courses(:one).evaluation_instances.build(course: courses(:one), title: "test", date: 2017-12-1, passing_score: 5, top_score: 10)
    assert_equal(0, evaluation.percentage_of_approved )
    evaluation.scores.build(student: students(:one), score: 1)
    
    assert_equal(1, evaluation.scores.all)
  end 

  test "must know the number of absent students" do 
    evaluation = evaluation_instances(:two)
    assert_equal(1, evaluation.number_of_absentees)
  end

  test "the score must be equal to score specificate" do 
    evaluation = evaluation_instances(:one)
    assert_equal(80, (evaluation.score_of_student students(:one)))
  end

  
end
