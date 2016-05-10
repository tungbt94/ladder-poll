require 'rails_helper'

RSpec.describe "StaffsEdits", type: :request do
  describe "GET /staffs_edits" do
    it "works! (now write some real specs)" do
      get staffs_edits_path
      expect(response).to have_http_status(200)
    end
  end
end
