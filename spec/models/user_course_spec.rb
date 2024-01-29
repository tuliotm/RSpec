require 'rails_helper'

RSpec.describe UserCourse, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:course) }
end
