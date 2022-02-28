RSpec.describe PlaybillSerializer do
  let(:playbill) { build :playbill }

  subject { described_class.new(playbill) }

  it "includes the expected attributes" do
    expect(subject.attributes.keys).to contain_exactly(
      :start_date, :finish_date, :title
    )
  end

  it "has splitted dates from daterange" do
    expect(subject.start_date).to be_a(Date)
    expect(subject.finish_date).to be_a(Date)
  end
end
