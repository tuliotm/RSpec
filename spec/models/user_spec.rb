require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:user_courses) }
    it { should have_many(:courses).through(:user_courses) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "instance methods" do
    it "#name_and_email" do
      user = User.create(email: 'jhon@doe', name: 'Jhon Doe')
      expect(user.name_and_email).to eq('Jhon Doe - jhon@doe - ' + Date.current.to_s)
    end
  end

  # another way ---------------
  context "instance methods 2" do
    before do
      Timecop.freeze("01/01/2024".to_date)
    end

    after do
      Timecop.return
    end

    it "#name_and_email" do
      user = User.create(email: 'jhon@doe', name: 'Jhon Doe')
      expect(user.name_and_email).to eq('Jhon Doe - jhon@doe - 2024-01-01')
    end
  end
end
