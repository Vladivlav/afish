RSpec.describe Playbill, type: :model do
  let!(:inactive_playbills) do
    create_list(:playbill, 2, status: Playbill.statuses[:archived])
  end

  let!(:active_paybills) { create_list(:playbill, 3) }

  describe ".active" do
    it "includes only active playbills" do
      expect(Playbill.active.pluck(:id)).to match_array(active_paybills.pluck(:id))
    end

    it "excludes inactive playbills" do
      expect(Playbill.active.pluck(:id)).not_to match_array(inactive_playbills.pluck(:id))
    end
  end
end
