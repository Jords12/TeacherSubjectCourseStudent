require "application_system_test_case"

class StudentsTest < ApplicationSystemTestCase
  setup do
    @student = students(:one)
  end

  test "visiting the index" do
    visit students_url
    assert_selector "h1", text: "Students"
  end

  test "should create student" do
    visit students_url
    click_on "New student"

    fill_in "Name", with: @student.name
    fill_in "Number of units", with: @student.number_of_units
    fill_in "Total assessment", with: @student.total_assessment
    fill_in "Year level", with: @student.year_level
    click_on "Create Student"

    assert_text "Student was successfully created"
    click_on "Back"
  end

  test "should update Student" do
    visit student_url(@student)
    click_on "Edit this student", match: :first

    fill_in "Name", with: @student.name
    fill_in "Number of units", with: @student.number_of_units
    fill_in "Total assessment", with: @student.total_assessment
    fill_in "Year level", with: @student.year_level
    click_on "Update Student"

    assert_text "Student was successfully updated"
    click_on "Back"
  end

  test "should destroy Student" do
    visit student_url(@student)
    click_on "Destroy this student", match: :first

    assert_text "Student was successfully destroyed"
  end
end
