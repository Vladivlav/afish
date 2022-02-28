class NewPlaybillContract < Dry::Validation::Contract
  params do
    required(:start_date).value(:date)
    required(:finish_date).value(:date)
    required(:title).filled(:string)
  end

  rule(:finish_date) do
    if value < values[:start_date]
      key.failure("finish date cannot be less than start date")
    else
      values[:duration] = values[:start_date]..values[:finish_date]
    end
  end
end
