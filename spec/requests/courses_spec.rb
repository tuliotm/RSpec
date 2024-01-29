require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "GET /index" do
    let!(:course1) { create(:course) }
    let!(:course2) { create(:course) }

    context "success" do
      before { get courses_path }

      it "should list courses" do
        expect(response).to have_http_status(200)
      end

      it "assigns @courses" do
        expect(assigns[:courses]).to match_array([course1, course2])
      end
    end
  end

  describe "GET /show/{id}" do
    let(:course) { create(:course) }

    context "success" do
      before { get course_path(course) }
      it "should list a course" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /new" do
    before { get "/courses/new" }

    context "success" do
      it "status of response is success" do
        expect(response).to have_http_status(:ok)
      end

      it "assigns @course" do
        expect(assigns[:course]).not_to(be_nil)
      end
    end
  end

  describe "POST /create" do
    context "success" do
      let(:course_attributes) do
        { 
          course: {
            title: Faker::Book.name,
            video_url: Faker::Internet.url,
            status: [:draft, :published].sample 
          } 
        }
      end

      before do
        post courses_path, params: course_attributes 
      end
      
      
      it "should create course" do
        expect(response).to have_http_status(302)
      end

      it "redirects to show" do
        expect(response).to redirect_to(course_path(Course.last))
      end
    end

    context "failure" do
      let(:course_invalid_attributes) do
        { course: {name: ""} }
      end

      before do
        post courses_path, params: course_invalid_attributes
      end

      it "should return unprocessable_entity" do
        expect(response).to have_http_status(422)
      end

      it "renders action" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH /update" do
    context "success" do
      let!(:course) { create(:course) }

      before do
        patch course_path(course), params: { course: { title: "New Title Updated" } }
      end

      it "return status code 302" do
        expect(response).to have_http_status(302)
      end

      it "render show" do
        expect(response).to redirect_to(Course.find(course.id))
      end
    end

    context "failure" do
      let(:course) { create(:course) }

      before do
        patch course_path(course), params: { course: { title: "" } }
      end

      it "returns unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "render template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /destroy" do
    let(:course) { create(:course) }

    before do
      delete course_path(course)
    end

    it "redirects to courses" do
      expect(response).to redirect_to(courses_path)
    end

    it "return status code 204" do
      expect(response).to have_http_status(302)
    end

    it "delete the user" do
      expect{ Course.find(course.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "set flash message" do
      expect(flash[:notice]).to eq("Course was successfully destroyed.")
    end
  end
end
