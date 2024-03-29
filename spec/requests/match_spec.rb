require 'rails_helper'

RSpec.describe "Matches", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/match/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/match/show"
      expect(response).to have_http_status(:success)
    end
  end

end
