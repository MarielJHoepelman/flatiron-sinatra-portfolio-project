require 'spec_helper'

describe ApplicationController do

  describe "Homepage" do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to Wishable")
      expect(last_response.body).to include("Signup")
      expect(last_response.body).to include("Log in")
    end
  end
end
