require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'John', bio: 'Doctor', photo: 'No link', posts_counter: 2) }
  before { subject.save }

  describe 'Model Validatons' do
    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to zero' do
      subject.posts_counter = -2
      expect(subject).to_not be_valid
    end
  end

  describe 'Model Methods' do
    it 'should show maximum of 3 posts upon calling the most_recent method' do
      expect(subject.most_recent.length).to be < 3
    end
  end
end
