require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    context "success" do
      before { get users_path }

      it "status of response is success" do
        expect(response).to have_http_status(:ok)
      end

      it "assigns @users" do
        expect(assigns[:users]).to match_array([user1, user2])
      end
    end
  end

  describe "GET /new" do
    context "success" do
      before { get "/users/new" }

      it "status of response is success" do
        expect(response).to have_http_status(:ok)
      end

      it "assigns @user" do
        expect(assigns[:user]).not_to(be_nil)
      end
    end
  end

  describe "POST /create" do
    context "success" do
      let(:user_attributes) do
        {
          user: {
            name: Faker::Name.name,
            email: Faker::Internet.email
          }
        }
      end

      before do
        post users_path, params: user_attributes
      end

      it "returns status code 302" do
        expect(response).to have_http_status(:found)
      end

      it "redirects to show" do
        expect(response).to redirect_to(user_path(User.last))
      end
    end

    context "failure" do
      let(:invalid_attributes) do
        { user: { name: "", email: "" } }
      end

      before do
        post users_path, params: invalid_attributes
      end

      it "returns status code unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "reders action" do
        expect(response).to(render_template(:new))
      end
    end
  end

  describe "GET /edit" do
    context "success" do
      let(:user) { create(:user) }

      before do
        get edit_user_path(user)
      end

      it "status of response is success" do
        expect(response).to have_http_status(200)
      end

      it "assigns user" do
        expect(assigns[:user]).to eq(user)
      end
    end
  end

  describe "PATCH /update" do
    context "success" do
      let(:user) { create(:user) }

      before do
        patch user_path(user), params: { user: { name: "John Doe updated" } }
      end

      it "redirects to show" do
        expect(response).to redirect_to(user_path(User.last))
      end

      it "returns status code 302" do
        expect(response).to have_http_status(302)
      end

      it "assigns @user" do
        expect(assigns[:user].name).to eq("John Doe updated")
      end
    end

    context "failure" do
      let(:user) { create(:user) }

      before do
        patch user_path(user.id), params: { user: { name: "" } } 
      end

      it "render edit" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destroy" do
    let(:user) { create(:user) }

    before do
      delete user_path(user)
    end

    it "return status code 204" do
      expect(response).to have_http_status(302)
    end

    it "redirect to users" do
      expect(response).to redirect_to(users_path)
    end

    it "deletes user" do
      expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'deletes the user' do
      expect(User.exists?(user.id)).to be_falsey
    end

    it 'sets the flash message' do
      expect(flash[:notice]).to eq("User was successfully destroyed.")
    end
  end
end
