require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/posts/index'
      expect(response.status).to eq(200)
      expect(response.body).to include('Posts#index')
      expect(response).to render_template('posts/index')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/posts/show'
      expect(response.status).to eq(200)
      expect(response.body).to include('Posts#show')
      expect(response).to render_template('posts/show')
    end
  end
end
