class UserCoursesController < ApplicationController
  def index
    @user_courses = UserCourse.all
  end
end
