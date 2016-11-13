require 'test_helper'

class CourseHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_history = course_histories(:one)
  end

  test "should get index" do
    get course_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_course_history_url
    assert_response :success
  end

  test "should create course_history" do
    assert_difference('CourseHistory.count') do
      post course_histories_url, params: { course_history: { course_description_id: @course_history.course_description_id, grade: @course_history.grade, student_id: @course_history.student_id } }
    end

    assert_redirected_to course_history_url(CourseHistory.last)
  end

  test "should show course_history" do
    get course_history_url(@course_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_history_url(@course_history)
    assert_response :success
  end

  test "should update course_history" do
    patch course_history_url(@course_history), params: { course_history: { course_description_id: @course_history.course_description_id, grade: @course_history.grade, student_id: @course_history.student_id } }
    assert_redirected_to course_history_url(@course_history)
  end

  test "should destroy course_history" do
    assert_difference('CourseHistory.count', -1) do
      delete course_history_url(@course_history)
    end

    assert_redirected_to course_histories_url
  end
end
