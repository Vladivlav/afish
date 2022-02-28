FactoryBot.define do
  factory :playbill, class: 'Playbill' do
    id { nil }
    sequence :duration do |n|
      (Date.today + (2 * n).days)..(Date.today + (2 * n + 1).days)
    end
    title { 'The big title' }
    status { Playbill.statuses[:active] }
  end
end
