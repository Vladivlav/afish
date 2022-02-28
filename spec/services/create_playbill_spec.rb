RSpec.describe CreatePlaybill do
  include Dry::Monads[:result]
  subject { described_class.new }

  context 'with valid parameters' do
    it 'creates new record' do
      params = {start_date: Date.today, finish_date: Date.today + 1.week, title: 'Cinderella'}
      expect { subject.call(params) } .to change { Playbill.count }.by(1)
    end
  end

  context 'with invalid parameters' do
    it 'returns errors' do
      params = {start_date: 'not a date', finish_date: 'not a date', title: 28}
      expect(subject.call(params)).to be_failure
    end
  end
end
