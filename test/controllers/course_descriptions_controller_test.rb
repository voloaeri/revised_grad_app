require 'test_helper'

class CourseDescriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_description = course_descriptions(:one)
  end

  test "should get index" do
    get course_descriptions_url
    assert_response :success
  end

  test "should get new" do
    get new_course_description_url
    assert_response :success
  end

  test "should create course_description" do
    assert_difference('CourseDescription.count') do
      post course_descriptions_url, params: { course_description: { category: @course_description.category, hours: @course_description.hours, name: @course_description.name, number: @course_description.number, section: @course_description.section, semester: @course_description.semester, teacher: @course_description.teacher } }
    end

    assert_redirected_to course_description_url(CourseDescription.last)
  end

  test "should show course_description" do
    get course_description_url(@course_description)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_description_url(@course_description)
    assert_response :success
  end

  test "should update course_description" do
    patch course_description_url(@course_description), params: { course_description: { category: @course_description.category, hours: @course_description.hours, name: @course_description.name, number: @course_description.number, section: @course_description.section, semester: @course_description.semester, teacher: @course_description.teacher } }
    assert_redirected_to course_description_url(@course_description)
  end

  test "should destroy course_description" do
    assert_difference('CourseDescription.count', -1) do
      delete course_description_url(@course_description)
    end

    assert_redirected_to course_descriptions_url
  end
end
