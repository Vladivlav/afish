class PlaybillsController < ApplicationController
  def index
    render json: Playbill.active, each_serializer: PlaybillSerializer
  end

  def create
    new_playbill = CreatePlaybill.new.call(create_params)
    if new_playbill.success?
      render json: new_playbill.value!, status: :created
    else
      render json: { errors: new_playbill }, status: :bad_request
    end
  rescue PG::ExclusionViolation
    render json: { errors: ['Chosen dates are busy. Please, choose another ones.'] }, status: :bad_request
  end

  def delete
    playbill = Playbill.find(params[:id])
    playbill.update(status: Playbill.statuses[:archived])
    render json: playbill
  end
  
  private

  def create_params
    params.permit(:title, :start_date, :finish_date)
  end
end
