require 'rails_helper'

RSpec.describe Staff, type: :model do
  before(:all) do
    @staff = Staff.new
    @staff_1 = Staff.find(2)
    @staff_2 = Staff.find(3)
  end

  describe " set_active" do
    context "for not actived staff" do
      it "actived is true" do
        @staff.set_active
        expect(@staff.actived).to eq true
      end
    end

    context "for actived staff" do
      it "return false" do
        expect(@staff_1.set_active).to eq false
      end
    end
  end
end
