class CreatePlaybill
  include Dry::Monads[:result]

  def call(params)
    playbill_form = NewPlaybillContract.new.call(params.to_h.symbolize_keys)

    if playbill_form.success?
      playbill = Playbill.create!(playbill_form.to_h.slice(:duration, :title))
      Success(playbill)
    else
      Failure(playbill_form)
    end
  end
end