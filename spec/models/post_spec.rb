require 'rails_helper'

describe Post, type: :model do
  it { should belong_to :user }
  it { should have_many :rates }

  let(:post_attributes) { FactoryBot.attributes_for :post }
  let(:user_attributes) { FactoryBot.attributes_for :user }
  let(:post) { Post.create_with_user! post_attributes, user_attributes }

  describe 'Create with user' do
    context 'normal' do
      it { post.should be_persisted }
      it { post.user.should be_persisted }
    end
  end

  describe 'Rate' do
    before do
      post.rate! 2
      post.rate! 4
    end
    it { post.average_rate.should eq 3 }
    it 'should increment count of rates' do
      expect {
        post.rate! 2
        post.rate! 4
      }.to change { post.rates.count }.by(2)
    end
  end

  describe 'Top' do
    before do
      FactoryBot.create_list(:post_with_user, 5).each_with_index do |post, i|
        post.rate! i + 1
      end
    end
    it { Post.top(3).length.should eq 3 }
    it { Post.top(5).length.should eq 5 }
    it { Post.top(10).length.should eq 5 }
  end
end
