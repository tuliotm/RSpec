require 'rails_helper'

RSpec.describe "UsersCourses", type: :request do
  describe "GET /index" do
    let(:user_course) { create(:user_course) }

    context "success" do
      before { get user_courses_index_path }

      it "should list all users courses" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
