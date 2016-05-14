require 'rails_helper'

RSpec.describe Poll, :type => :model do
  before(:all) do
    @poll_1 = Poll.find(1)
    @poll_2 = Poll.find(2)
  end
  describe ".get_list_option" do
    context "no option" do
      it "return 0 option" do
        expect(@poll_2.get_list_option.size).to eq 0
      end
    end

    context "have option" do
      it "return != 0 option" do
        expect(@poll_1.get_list_option.size).to eq 1
      end
    end
  end

  describe ".get_list_staff_voted" do
    context "no vote" do
      it "return 0 staff" do
          expect(@poll_2.get_list_staff_voted.size).to eq 0
      end
    end

    context "voted" do
      it "return != 0 staff" do
          expect(@poll_1.get_list_staff_voted.size).to eq 1
      end
    end
  end
end
