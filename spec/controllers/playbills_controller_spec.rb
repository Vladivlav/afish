RSpec.describe PlaybillsController, type: :controller do
  let(:valid_attributes) do
    {
        title: 'The Nutcracker',
        start_date: Date.today + 6.days,
        finish_date: Date.today + 7.weeks,
        status: Playbill.statuses[:active]
    }
  end
  
  describe "GET index" do
    let!(:inactive_playbills) do
      create_list(:playbill, 2, status: Playbill.statuses[:archived])
    end
    let!(:active_paybills) { create_list(:playbill, 3) }
  
    before(:each) { get :index }

    it 'returns all active playbills' do
      response_data = JSON.parse(response.body)
      expect(response_data.count).to eq(Playbill.active.count)
    end

    it 'returns only active playbills' do
      response_playbill_ids = JSON.parse(response.body).pluck(:id)
      expect(Playbill.where(id:response_playbill_ids)).to all( be_active )
    end

    it 'returns code 200' do
      expect(response.code).to eq("200")
    end
  end

  describe "POST create" do
    it 'creates a new record' do
      post :create, { params: valid_attributes }
      expect(response.status).to eq(201)
    end

    it 'doesnt create event on days which is already reserved' do
      CreatePlaybill.new.call(valid_attributes)
      valid_attributes[:start_date] = valid_attributes[:finish_date]
      valid_attributes[:finish_date] = valid_attributes[:finish_date] + 3.days
      expect { post :create, { params: valid_attributes } }.to raise_error
    end
  end

  describe "PATCH delete" do
    it 'disable playbill' do
      playbill = CreatePlaybill.new.call(valid_attributes).value!
      patch :delete, { params: { id: playbill.id } }
      expect(playbill).to be_archived
    end
  end
end
