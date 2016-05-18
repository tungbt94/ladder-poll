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

  describe " get_manager_level" do
    context "for new staff or manage no one" do
      it "return 1" do
        expect(@staff.get_manager_level).to eq 1
        expect(@staff_2.get_manager_level).to eq 1
      end
    end

    context "for a staff is managings some staff" do
      it "return > 1" do
        expect(@staff_1.get_manager_level > 1).to eq true
      end
    end
  end

  describe "get_score" do
    context "new staff" do
      it "return 1" do
        expect(@staff.get_score).to eq 1
      end
    end

    context "not new staff" do
      it "return > 1" do
        expect(@staff_1.get_score > 1).to eq true
      end
    end
  end

  describe "get_voted_poll" do
    context "not voted yet" do
      it "return 0 poll" do
        expect(@staff.get_voted_poll.size).to eq 0
      end
    end

    context "voted" do
      it "return > 0" do
        expect(@staff_1.get_voted_poll.size > 0).to eq true
      end
    end
  end

  describe ".is_managing(id)" do
    context "staff: new staff, id: staff" do
      it "return false" do
        expect(@staff.is_managing(1)).to eq false
      end
    end

    context "id: new staff actived = false" do
      @staff = Staff.new
      it "return false" do
        expect(@staff_1.is_managing(@staff.id)).to eq false
      end
    end

    context "id: staff not be managed" do
      staff_3 = Staff.find(9)
      it "return false" do
        expect(@staff.is_managing(staff_3.id)).to eq false
      end
    end

    context "id: staff is managed" do
      staff_3 = Staff.find(6)
      it "return true" do
        expect(@staff_1.is_managing(staff_3)).to eq true
      end
    end
  end
end
