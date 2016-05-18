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

  describe " get_branch" do
    context "new staff" do
      it "return 0 staff" do
        expect(@staff.get_branch.size).to eq 0
      end
    end

    context "manager_level = 1" do
      it "return 0 staff" do
        expect(@staff_2.get_branch.size).to eq 0
      end
    end

    context "manager_level = 2" do
      staff = Staff.find(4)
      it "return > 1 staff" do
        expect(staff.get_branch.size > 1).to eq true
      end
    end

    context "manager_level > 2" do
      it "return > 1 staff" do
        expect(@staff_1.get_branch.size > 1).to eq true
      end
    end
  end

  describe " scope get_staffs_managed_by" do
    context "id = nil" do
      it "return all staff" do
        expect(Staff.get_staffs_managed_by(@staff.id).size).to eq Staff.all.size
      end
    end

    context "manager_level = 1" do
      it "return 0 staff" do
        expect(Staff.get_staffs_managed_by(@staff_2.id).size == 0).to eq true
      end
    end

    context "manager_level > 1" do
      it "return > 0 staff" do
        expect(Staff.get_staffs_managed_by(@staff_1.id).size > 0).to eq true
      end
    end
  end

  describe " self.max_manager_level" do
    context "all is new staff" do
      staff = Staff.new
      staff_1 = Staff.new
      list_staff = Array.new
      list_staff.push(staff)
      list_staff.push(staff_1)
      it "return 1" do
        expect(Staff.max_manager_level(list_staff)).to eq 1
      end
    end

    context "all staff have the same manager_level" do
      staff = Staff.find(8)
      staff_1 = Staff.find(4)
      list_staff = Array.new
      list_staff.push(staff)
      list_staff.push(staff_1)
      it "return same manager_level" do
        expect(Staff.max_manager_level(list_staff)).to eq staff.get_manager_level
      end
    end

    context "have difference manager_level" do
      staff = Staff.find(8)
      staff_1 = Staff.find(9)
      list_staff = Array.new
      list_staff.push(staff)
      list_staff.push(staff_1)
      it "return max manager_level" do
        expect(Staff.max_manager_level(list_staff)).to eq staff.get_manager_level
      end
    end
  end

  describe " .get_sum_score" do
    context "all is new staff" do
      staff = Staff.new
      staff_1 = Staff.new
      list_staff = Array.new
      list_staff.push(staff)
      list_staff.push(staff_1)
      it "result >= 1 * number staff" do
        expect(Staff.get_sum_score(list_staff) >= 2).to eq true
      end
    end

    context "all is staff actived" do
      staff = Staff.find(8)
      staff_1 = Staff.find(4)
      list_staff = Array.new
      list_staff.push(staff)
      list_staff.push(staff_1)
      sum_score = staff.get_score + staff_1.get_score
      it "result = sum key" do
        expect(Staff.get_sum_score(list_staff)).to eq sum_score
      end
    end
  end

end
