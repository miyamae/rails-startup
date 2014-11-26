require 'spec_helper'

RSpec.describe 'users', type: :request do
  include RequestHelper

  let(:user_structure) do
    {
      'id' => a_kind_of(Integer),
      'key' => a_kind_of(String),
      'name' => a_kind_of(String).or(a_nil_value),
      'nick_name' => a_kind_of(String).or(a_nil_value),
      'email' => a_kind_of(String).or(a_nil_value),
      'bio' => a_kind_of(String).or(a_nil_value),
      'created_at' => a_kind_of(String),
      'updated_at' => a_kind_of(String)
    }
  end

  describe 'GET /v1/users' do
    let!(:users) { create_list(:user, 3) }

    it 'returns user resources', autodoc: true do
      get '/v1/users', params, env
      expect(response).to have_http_status(200)
      expect(JSON(response.body)).to be_an_instance_of(Array)
    end
  end

  describe 'GET /v1/users/:user_id' do
    let!(:user) { create(:user, name: 'alice') }

    it 'returns user resource', autodoc: true do
      get "/v1/users/#{user.id}", params, env
      expect(response).to have_http_status(200)
      expect(JSON(response.body)).to match(user_structure)
    end
  end

  describe 'PUT /v1/users/:user_id' do
    let!(:user) { resource_owner }
    before { params[:name] = 'bob' }

    context 'with owned resource', autodoc: true do
      it 'updates user resource' do
        put "/v1/users/#{user.id}", params, env
        expect(response).to have_http_status(204)
      end
    end

    context 'without owned resource' do
      let!(:other) { create(:user, name: 'raymonde') }

      it 'returns 403' do
        put "/v1/users/#{other.id}", params, env
        expect(response).to have_http_status(403)
      end
    end
  end
end
