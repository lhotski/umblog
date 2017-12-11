require 'rails_helper'

describe PostsController, type: :controller do
  include JsonHelpers

  describe 'POST create' do
    let(:attributes) { FactoryBot.attributes_for(:post).merge(login: FFaker::Internet.user_name) }
    before { post :create, params: attributes }
    it { assigns(:post).should be_persisted }
    it { response.should be_success }
    it { json[:subject].should eq attributes[:subject] }
  end

  describe 'POST rate' do
    before do
      @post = FactoryBot.create(:post_with_user)
      post :rate, params: {id: @post.id, value: 5}
    end
    it { response.should be_success }
    it { json[:average_rate].should eq 5 }
  end

  describe 'GET top' do
    before { FactoryBot.create_list :post_with_user, 5}
    before { get :top }
    it { response.should be_success }
    it { json.length.should eq 5 }
  end

  describe 'GET ips_by_logins' do
    before do
      @posts = FactoryBot.create_list :post_with_user, 5
      @logins = @posts[0..1].map(&:user_login)
      get :ips_by_logins, params: {logins: @logins}
    end
    it { response.should be_success }
    it { json.should_not be_empty }
    it { @logins.should include(*json[0][:logins]) }
  end
end
