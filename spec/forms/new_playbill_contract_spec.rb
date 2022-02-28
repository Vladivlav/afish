RSpec.describe NewPlaybillContract do
  subject { described_class.new }

  describe 'playbill parameters' do
    it 'valid for event with one week long' do
      params = {start_date: Date.today, finish_date: Date.today + 1.week, title: 'Cinderella'}
      expect(subject.call(params)).to be_success
    end

    it 'valid for one-day event' do
      params = {start_date: Date.today, finish_date: Date.today, title: 'The bolt'}
      expect(subject.call(params)).to be_success
    end

    it 'returns duration as a daterange' do
      params = {start_date: Date.today, finish_date: Date.today + 1.week, title: 'Cinderella'}
      result = subject.call(params).to_h
      expect(result[:duration]).to be_a(Range)
    end

    it 'fails with invalid dates' do
      params = {start_date: Date.today, finish_date: Date.today - 1.day, title: 'Schrek III'}
      expect(subject.call(params)).to be_failure
    end

    it 'fails with missing params' do
      expect(subject.call({})).to be_failure
    end
  end
end
