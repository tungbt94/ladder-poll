require 'rails_helper'

RSpec.describe Option, :type => :model do
  before(:all) do
    @option_1 = Option.find(1)
    @option_2 = Option.find(2)
  end

  describe " .get_list_staff_voted " do
    context "no voted" do
      it "return 0 staff" do
        expect(@option_2.get_list_staff_voted.size).to eq 0
      end
    end

    context "have staff voted" do
      it "return != 0 staff" do
        expect(@option_1.get_list_staff_voted.size).to eq 2
      end
    end
  end

  describe " .get_sum_score " do
    context "no voted" do
      it "return 0 score" do
        expect(@option_2.get_sum_score).to eq 0
      end
    end

    context "have staff voted" do
      it "return != 0 score" do
        expect(@option_1.get_sum_score.to_i).to eq 19
      end
    end
  end
end
